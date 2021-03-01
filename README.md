# eel5820_hw3

To run, use the colorTransferAll wrapper script with no arguments.
This will create every combination of image using images from the src_images
directory as the source image and images from the tgt_images directory as the
target image. All outputs will be save as subplot images in the output_images
directory. If you'd like to use your own images with this script, they will have
to be in the same format as mine: cropped_im000.jpg, cropped_im001.jpg, ...

I cropped the images and created the downsizeIms.m script to resize all images
to have the same resolution (798x798) in this case, since that was the smallest
resolution out of all images I chose.(This will only work with the naming convention i've chosen)

To run the algorithm with your own images, simply ensure they are the same dimensions
using MATLABs imresize() function, then call colorTransfer on each combination of src/tgt image paths
including the desired output path as well.