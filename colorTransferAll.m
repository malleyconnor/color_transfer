function colorTransferAll(src_im_path, tgt_im_path, output_path)
    if ~exist('output_path', 'var')
        output_path = './output_images/';
    end
    if ~exist('src_im_path', 'var')
        src_im_path = './src_images';
    end
    if ~exist('tgt_im_path', 'var')
        tgt_im_path = './tgt_images';
    end
    
    % Getting images that have already been cropped/scaled
    src_ims = {dir(fullfile(src_im_path, '/cropped*')).name};
    tgt_ims = {dir(fullfile(tgt_im_path, '/cropped*')).name};
    
    
    % Just for creating output filenames...
    names = {dir(fullfile(src_im_path, '/cropped*')).name};
    src_im_names = {};
    for j=1:length(src_ims)
        src_im_names{j} = erase(names{j}, 'cropped_'); 
        src_im_names{j} = erase(src_im_names{j}, '.jpg');
    end
    names = {dir(fullfile(src_im_path, '/cropped*')).name};
    tgt_im_names = {};
    for j=1:length(tgt_ims)
        tgt_im_names{j} = erase(names{j}, 'cropped_');
        tgt_im_names{j} = erase(tgt_im_names{j}, '.jpg');
    end

    % Applying colorTransfer to each combination of src/tgt images
    for j=1:length(src_ims)
        for k=1:length(tgt_ims)       
            out_file = sprintf('%ssrc_%stgt.jpg', src_im_names{j}, tgt_im_names{k});
            
            I = colorTransfer(fullfile(src_im_path, src_ims{j}), ...
                fullfile(tgt_im_path, tgt_ims{k}), ...
                fullfile(output_path, out_file));
        end
    end
    
end