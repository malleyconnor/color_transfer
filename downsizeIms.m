function downsizeIms(src_im_path, tgt_im_path)
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