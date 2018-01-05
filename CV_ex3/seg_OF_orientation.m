% Detect pixels that move to the same direction
% Input: O: optical flow orienation matrix, Th: threshold
% Output: segmented image – each segment in a different color
function I = seg_OF_orientation(O,th)
r = 255/(2*pi);
O = r*O;
th = r*th;
O = O-rem(O,th);
L = bwlabel(O);
I = L;