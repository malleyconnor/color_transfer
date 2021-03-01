function downsizeIms(src_im_path, tgt_im_path)
%colorTransfer
%
%   Description: Downscales all images in the src_im_path and tgt_im_path
%   to a square image of the minimum size between the two directories. All
%   images must have the format im000.jpg, im001.jpg, etc... Outputs images
%   started with "cropped" in the same directories.
%
%   Inputs:
%       src_im_path (str) - path to source image directory.
%
%       tgt_im_path (str) - path to target image directory.
%
%
%   Returns: n/a
%
    src_ims = {dir(fullfile(src_im_path, '/im*')).name};
    tgt_ims = {dir(fullfile(tgt_im_path, '/im*')).name};
    
    
    % Scanning source ims for min resolutions
    min_size = Inf;
    for j=1:length(src_ims)
        im_j = imread(fullfile(src_im_path, src_ims{j}));
        
        minj = min(size(im_j, 1), size(im_j, 2));
        
        if (minj < min_size)
           min_size = minj; 
        end
    end
    
    % Scanning target ims for min resolution
    for j=1:length(tgt_ims)
        im_j = imread(fullfile(tgt_im_path, tgt_ims{j}));
        
        minj = min(size(im_j, 1), size(im_j, 2));
        
        if (minj < min_size)
            min_size = minj;
        end
    end
    
    output_res = [min_size min_size];
    disp(min_size)
    % Resizing src images
    for j=1:length(src_ims)
        im_j = imread(fullfile(src_im_path, src_ims{j}));
        im_j = imresize(im_j, output_res);
        imfile = sprintf('cropped_im%03d.jpg', j-1);
        imwrite(im_j, fullfile(src_im_path, imfile));
    end
    
    % Resizing tgt images
    for j=1:length(tgt_ims)
        im_j = imread(fullfile(tgt_im_path, tgt_ims{j}));
        im_j = imresize(im_j, output_res);
        imfile = sprintf('cropped_im%03d.jpg', j-1);
        imwrite(im_j, fullfile(tgt_im_path, imfile));
    end
end