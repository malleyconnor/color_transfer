function I=colorTransfer(source_im_path, target_im_path, output_path)
    src_im = double(imread(source_im_path));
    tgt_im = double(imread(target_im_path));
    
    % Flattened src/tgt images
    src_flattened = reshape(src_im, [size(src_im, 1)*size(src_im, 2) 3]);
    tgt_flattened = reshape(tgt_im, [size(tgt_im, 1)*size(tgt_im, 2) 3]);
    
    % Mean of RGB values
    mean_src = mean(src_flattened, 1);
    mean_tgt = mean(tgt_flattened, 1);
    
    % Covariance of src and tgt images
    cov_src = cov(src_flattened);
    cov_tgt = cov(tgt_flattened);
    
    % Singular value decomposition of src/tgt covariance matrices
    [U_src, lambda_src, V_src] = svd(cov_src);
    [U_tgt, lambda_tgt, V_tgt] = svd(cov_tgt);
    
    % Source rotation
    R_src = eye(4);
    R_src(1:3,1:3) = U_src;

    
    % Target rotation
    R_tgt = eye(4);
    R_tgt(1:3,1:3) = inv(U_tgt);

    
    % Source Translation
    T_src = eye(4);
    T_src(1:3,4) = mean(src_flattened, 1);

    % Target Translation
    T_tgt = eye(4);
    T_tgt(1:3,4) = -1*mean(tgt_flattened, 1);
    
    % Source scale
    S_src = eye(4);
    S_src = S_src.*diag(sqrt([diag(lambda_src); 1]));
    
    % Target scale
    S_tgt = eye(4);
    S_tgt = S_tgt.*diag(1./sqrt([diag(lambda_tgt); 1]));
    
    
    % Applying filter...
    I_tgt = tgt_flattened;
    I_tgt(:,4) = ones(size(I_tgt,1),1);
    
    
    I = (T_src*R_src*S_src*S_tgt*R_tgt*T_tgt*I_tgt')';
    
    % Getting rid of the dummy variable...
    I(:,4) = [];
    
    % Normalizing, rounding, and casting to uint8
    for j=1:size(I, 2)
       % Max/min val of src img
       maxVal = max(tgt_flattened(:,j));
       minVal = min(tgt_flattened(:,j));
       I(:,j) = normalize(I(:,j), 'range', [minVal, maxVal]); 
    end
    I = uint8(round(I));
    
    % Reshaping image to 2D
    I = reshape(I, [size(src_im, 1) size(src_im, 2) 3]);

    
    % Displaying images
    f = figure();set(gcf, 'Visible', 'off');set(gcf, 'DefaultAxesPosition', [0.1, 0.1, 0.8, 0.8]);
    subplot(1,3,1), imshow(uint8(src_im)), title('Source image');
    subplot(1,3,2), imshow(uint8(tgt_im)), title('Target image');
    subplot(1,3,3),  imshow(I), title('Filtered target image');
    
    % Saving all 3 images in a subplot if output path specified, otherwise just returns image
    if exist('output_path', 'var')
      %  im2save = getframe;
       % imwrite(im2save.cdata, output_path);
       exportgraphics(f, output_path, 'resolution', size(src_im, 1));
    end
end