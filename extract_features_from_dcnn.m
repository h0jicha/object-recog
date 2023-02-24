% 画像データからDCNN特徴量を抽出する
function [features, labels] = extract_features_from_dcnn(cnn_model, layer_name, image_dataset, labels)
    % 画像をリサイズして1つの配列にまとめる
    net = cnn_model;
    input_size = cnn_model.Layers(1).InputSize(1:2);
    IM = [];
    for i = 1:size(image_dataset,1)
        img = image_dataset{i};
        reimg = imresize(img, net.Layers(1).InputSize(1:2));
        IM=cat(4, IM, reimg);
    end
    
    % CNNから特徴量を抽出する
    dcnnf = activations(cnn_model, IM, layer_name);
    dcnnf = squeeze(dcnnf);
    dcnnf = dcnnf/norm(dcnnf);
    features = dcnnf';
    labels = labels; % わかりやすさのため
end