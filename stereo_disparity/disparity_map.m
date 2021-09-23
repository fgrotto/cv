% Open the two images
I1 = imread('2_tri1.jpg');
I2 = imread('2_tri2.jpg');

figure(1)
imshow(I1);
figure(2)
imshow(I2);
figure(3);
%     stereoAnaglyph Create a red-cyan anaglyph from a stereo pair of images
  
%     J = stereoAnaglyph(I1, I2) combines images I1 and I2 into
%     a red-cyan anaglyph, which can be viewed with red-blue stereo glasses. 
%     I1 and I2 can be grayscale or truecolor images, and they must have the 
%     same size. J is a truecolor image of the same size as I1 and I2.
imshow(stereoAnaglyph(I1,I2));


disparityRange = [-6 10];
%     disparityMap = disparity(I1,I2) returns the disparity map for a pair of
%     stereo images, I1 and I2. I1 and I2 must have the same size and must be
%     rectified such that the corresponding points are located on the same
%     rows. This rectification can be performed using the rectifyStereoImages
%     function. The returned disparity map has the same size as I1 and
%     I2.
disparityMap = disparity(rgb2gray(I1), rgb2gray(I2), 'BlockSize', 15, 'DisparityRange', disparityRange);

% Display the result
figure;
imshow(disparityMap, disparityRange);
    