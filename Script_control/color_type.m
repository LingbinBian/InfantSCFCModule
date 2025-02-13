function [colormap_type] = color_type(v)
% Colormap
% v: a vector of labels

color_1=[0.69,0.19,0.38];
color_2=[1.00,0.89,0.52];
color_3=[0.25,0.41,0.88];
color_4=[0.00,0.79,0.34];
color_5=[0.63,0.32,0.18];
color_6=[0.50,0.54,0.53];
color_7=[0.53,0.81,0.92];
color_8=[0.63,0.40,0.83];
color_9=[0.74,0.56,0.56];
color_10=[0.16,0.14,0.13];
color_11=[1.00,0.50,0.31];
color_12=[1.00,0.00,0.00];
color_13=[0.39,0.19,0.38];
color_14=[0.50,0.89,0.52];
color_15=[0.12,0.41,0.88];
color_16=[0.31,0.32,0.18];
color_17=[1.00,0.00,1.00];
color_18=[0.90,0.54,0.53];
color_19=[0.27,0.21,0.92];
color_20=[0.17,0.57,0.17];
color_21=[0.50,0.07,0.27];
color_22=[0.37,0.97,0.57];
color_23=[0.97,0.17,0.47];
color_24=[0.51,0.37,0.87];
color_25=[0.17,0.17,0.67];
color_26=[0.27,0.70,0.27];
color_27=[0.00,0.27,0.31];
color_28=[0.77,0.77,0.47];
color_29=[0.02,0.87,0.55];
color_30=[0.27,0.27,0.91];
color_31=[0.59,0.19,0.58];
color_32=[0.90,0.89,0.62];
color_33=[0.15,0.41,0.98];
color_34=[0.00,0.59,0.05];
color_35=[0.23,0.42,0.28];
color_36=[0.70,0.44,0.53];
color_37=[0.13,0.21,0.92];
color_38=[0.93,0.40,0.23];
color_39=[0.74,0.86,0.16];
color_40=[0.96,0.53,0.93];


color_map_RGB=[color_1;color_2;color_3;color_4;color_5;color_6;color_7;color_8;color_9;color_10;color_11;color_12;color_13;color_14;color_15;color_16;color_17;color_18;color_19;color_20;color_21;color_22;color_23;color_24;color_25;color_26;color_27;color_28;color_29;color_30;color_31;color_32;color_33;color_34;color_35;color_36;color_37;color_38;color_39;color_40];
colormap_type=color_map_RGB(unique(v),:);

end






