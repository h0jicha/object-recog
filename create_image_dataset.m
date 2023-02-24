% 画像データセットを読み込む
function images = create_image_dataset(image_paths)    
    n = length(image_paths);  % 画像数
    images = cell(1, n);  % 画像格納用セル配列
    
    for i=1:n
        img = imread(image_paths{i});
        images{i} = img;
    end
    
    % n*1に変更する
    images = images';

end