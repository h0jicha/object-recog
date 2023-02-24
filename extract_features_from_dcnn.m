% 画像データからDCNN特徴量を抽出する
function [features, labels] = extract_features_from_dcnn(cnn_model, layer_name, image_dataset, labels)
    % 画像をリサイズして1つの配列にまとめる
    net = cnn_model;
    input_size = cnn_model.Layers(1).InputSize(1:2);
    IM = [];
    for i = 1:size(image_dataset,1)
        img = image_dataset{i};
        % アスペクト比を保って227*227にリサイズする
        aspect_ratio = size(img,2) / size(img,1);
        reimg = imresize(img, [227 NaN]);
        if size(reimg, 2) > 227
            reimg = imresize(img, [NaN 227]);
        end
        % 余剰分は黒埋めする
        new_img = 0 * ones(227, 227, size(reimg, 3), 'uint8');
        x_offset = floor((227 - size(reimg, 2)) / 2);
        y_offset = floor((227 - size(reimg, 1)) / 2);
        new_img(y_offset+1:y_offset+size(reimg, 1), x_offset+1:x_offset+size(reimg, 2), :) = reimg;
%         figure();
%         imshow(new_img);
        IM=cat(4, IM, new_img);
    end
    
    % CNNから特徴量を抽出する
    dcnnf = activations(cnn_model, IM, layer_name);
    dcnnf = squeeze(dcnnf);
    dcnnf = dcnnf/norm(dcnnf);
    features = dcnnf';
    labels = labels; % わかりやすさのため
end