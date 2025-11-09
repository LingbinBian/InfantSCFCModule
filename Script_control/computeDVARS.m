function [DVARS_roi, mean_DVARS_roi, DVARS_global] = computeDVARS(ROI_timecourses, doPlot)
% computeDVARS - compute ROI-wise DVARS and global DVARS
%
% input:
%   ROI_timecourses: [T x N_ROI] matrix，each column: ROI BOLD time series
%   doPlot         : choosable，logic，whether to plot (default: false)
%
% output:
%   DVARS_roi      : [T-1 x N_ROI] DVARS of each TR and each ROI
%   mean_DVARS_roi : [1 x N_ROI] mean DVARS of each ROI
%   DVARS_global   : [T-1 x 1] global DVARS

if nargin < 2
    doPlot = false;
end

[T, N_ROI] = size(ROI_timecourses);

% time difference
diff_mat = diff(ROI_timecourses, 1, 1);  % [T-1 x N_ROI]

% ROI-wise DVARS: absolute value of each ROI
DVARS_roi = abs(diff_mat);  % [T-1 x N_ROI]

% ROI mean DVARS
mean_DVARS_roi = mean(DVARS_roi, 1);  % [1 x N_ROI]

% globel DVARS (all ROI RMS)
DVARS_global = sqrt(mean(diff_mat.^2, 2));  % [T-1 x 1]

% visualization
if doPlot
    figure;
    subplot(2,1,1);
    imagesc(DVARS_roi'); colorbar;
    xlabel('Time (TR)'); ylabel('ROI');
    title('ROI-wise DVARS over time');

    subplot(2,1,2);
    plot(DVARS_global, 'LineWidth', 1.5);
    xlabel('Time (TR)'); ylabel('Global DVARS');
    title('Global DVARS over time');
    grid on;
end

end
