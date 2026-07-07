
function animateNBP_2D(r_vec_list, t_list, m_list, AnimateStep, varargin)
%==========================================================================
%
% 2D animation of an N-body system (using x,y components only) with
% barycentric coordinates.
%
% INPUTS:
%   r_vec_list  : (Nt, N, 3)
%   t           : time vector of length Nt
%   m           : mass vector of length N
%   AnimateStep : animation stride (optional, default = 20)
%   Nanim       : number of uniformly spaced animation frames
%                 (optional, default = Nt)
%
% Author: G. Montseny
% Date: March 17, 2026
%
%==========================================================================


    % Default behavior
    draw_edges = true;

    % Parse varargin
    if ~isempty(varargin)
        for k = 1:length(varargin)
            if ischar(varargin{k}) || isstring(varargin{k})
                if strcmpi(varargin{k}, 'no edges')
                    draw_edges = false;
                end
            end
        end
    end

    % Defaults
    if nargin < 4
        AnimateStep = 20;
    end

    t = t_list;

    Nt = size(r_vec_list,1);
    N  = size(r_vec_list,2);

    if size(r_vec_list,3) ~= 3
        error('r_vec_list must have shape (Nt, N, 3).');
    end

    if length(t) ~= Nt
        error('Length of t must match the number of time steps.');
    end

    m = m_list(:);
    if length(m) ~= N
        error('m must be a mass vector of length N.');
    end

    t = t(:);

    mass_str = sprintf('Masses: [');
    for i = 1:N
        if i < N
            mass_str = [mass_str, sprintf('%.3g, ', m(i))];
        else
            mass_str = [mass_str, sprintf('%.3g', m(i))];
        end
    end
    mass_str = [mass_str, ']'];

    % -------------------------
    % Interpolation
    % -------------------------
    t_anim = linspace(t(1), t(end), Nt)';
    r_interp = zeros(Nt, N, 3);

    for i = 1:N
        r_interp(:,i,:) = interp1(t, squeeze(r_vec_list(:,i,:)), t_anim, 'pchip');
    end

    r_vec_list = r_interp;
    t = t_anim;
    Nt = Nt;

    % -------------------------
    % Keep only x,y
    % -------------------------
    r = r_vec_list(:,:,1:2);   % (Nt, N, 2)

    % -------------------------
    % Center of mass
    % -------------------------
    Mtot = sum(m);
    rcom = zeros(Nt,2);
    for i = 1:N
        rcom = rcom + m(i)*squeeze(r(:,i,:));
    end
    rcom = rcom/Mtot;

    % -------------------------
    % Marker sizes
    % -------------------------
    m_norm = m ./ max(m);
    markersize = max(5, 14 * sqrt(m_norm));

    % Colors
    bodyColors = lines(N);

    % -------------------------
    % Axis limits
    % -------------------------
    allx = [reshape(r(:,:,1), [], 1); rcom(:,1)];
    ally = [reshape(r(:,:,2), [], 1); rcom(:,2)];

    xmin = min(allx); xmax = max(allx);
    ymin = min(ally); ymax = max(ally);

    if xmin == xmax, xmin = xmin - 1; xmax = xmax + 1; end
    if ymin == ymax, ymin = ymin - 1; ymax = ymax + 1; end

    dx = xmax - xmin; 
    dy = ymax - ymin;

    xmin = xmin - 0.05*dx; xmax = xmax + 0.05*dx;
    ymin = ymin - 0.05*dy; ymax = ymax + 0.05*dy;

    % -------------------------
    % Figure
    % -------------------------
    figure('Position',[100 100 900 700]);
    clf

    for k = 1:AnimateStep:Nt
        clf
        hold on

        h_body = gobjects(N,1);

        % Trails
        for i = 1:N
            h_body(i) = plot(squeeze(r(1:k,i,1)), squeeze(r(1:k,i,2)), ...
                'LineWidth', 1, 'Color', bodyColors(i,:));
        end

        hcomtrail = plot(rcom(1:k,1), rcom(1:k,2), 'k--', 'LineWidth', 1.5);

        rk = squeeze(r(k,:,:));   % (N,2)
        rc = rcom(k,:);

        % Bodies
        for i = 1:N
            plot(rk(i,1), rk(i,2), 'o', ...
                'MarkerSize', markersize(i), ...
                'MarkerEdgeColor', 'k', ...
                'MarkerFaceColor', bodyColors(i,:), ...
                'HandleVisibility', 'off');
        end

        % Polygon
        if draw_edges
            plot([rk(:,1); rk(1,1)], [rk(:,2); rk(1,2)], ...
                'k-', 'LineWidth', 1.5, 'HandleVisibility', 'off');
        end

        % COM
        hcom = plot(rc(1), rc(2), 'p', ...
            'MarkerSize', 12, ...
            'MarkerEdgeColor', 'k', ...
            'MarkerFaceColor', 'g');

        % COM connectors
        for i = 1:N
            plot([rc(1), rk(i,1)], [rc(2), rk(i,2)], '--k', ...
                'HandleVisibility', 'off');
        end

        

        % -------------------------
        % Edge lengths with offset
        % -------------------------
        if draw_edges
            for i = 1:N
                j = i + 1;
                if i == N
                    j = 1;
                end
    
                ri = rk(i,:);
                rj = rk(j,:);
    
                d = norm(rj - ri);
                mid = 0.5*(ri + rj);
    
                % Edge direction
                v = rj - ri;
    
                % Normal vector
                nvec = [-v(2), v(1)];
                if norm(nvec) > 0
                    nvec = nvec / norm(nvec);
                end
    
                % Offset magnitude
                offset = 0.05 * max(dx,dy);
                pos = mid + offset * nvec;
    
                text(pos(1), pos(2), sprintf('%.2f', d), ...
                    'HorizontalAlignment', 'center', ...
                    'VerticalAlignment', 'middle', ...
                    'FontSize', 8, ...
                    'BackgroundColor', 'w', ...
                    'Margin', 1);
            end
        end

        xlabel('$x$','Interpreter','latex')
        ylabel('$y$','Interpreter','latex')
        title(sprintf('N-Body Animation, $t$ = %.6g', t(k)))
        subtitle(mass_str)

        bodyLabels = arrayfun(@(i) sprintf('Body %d Orbit', i), 1:N, 'UniformOutput', false);
        legend([h_body; hcomtrail; hcom], ...
            [bodyLabels, {'COM trail', 'COM'}], ...
            'Location', 'eastoutside')

        grid on
        box on
        axis equal
        xlim([xmin xmax])
        ylim([ymin ymax])

        drawnow limitrate
    end
end