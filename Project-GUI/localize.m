function [bounding_rect] = localize(I)

if(size(I,3)>1)
I = rgb2gray(I);
end
    level = graythresh(I);
    bw = im2bw(I,level);

    st = regionprops(~bw, 'BoundingBox' );
    Y = [];
for k = 1 : length(st)
  thisBB = st(k).BoundingBox;
   if(thisBB(3)<40)
       continue;
   end
   Y = [Y;k];
end

bounding_rect = st(Y);
end


