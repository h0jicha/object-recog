% 画像パス列から、それらの画像に対応するコードブックを作成します。
% ただし、特徴点抽出はrandom samplingによります。
% コードブックのサイズをnで指定します。
function codebook = create_codebook_random_sampling(filenames, n)
    features = []; % 全画像のSURF特徴をまとめたもの

    % 各パスの画像に対して、SURF特徴を取り出し、それを連結していく
    fileNum = size(filenames, 1);
    for i = 1 : fileNum
        I = rgb2gray(imread(filenames{i}));
        points = create_random_points(I, 1000); % random sampling
        [fts, ~] = extractFeatures(I,points);
        features = [features; fts];
    end

    % 連結したSURF特徴に対して、ランダムで特徴量を抽出する
    numFeatures = size(features, 1);
    numToExtract = 50000;
    if (numFeatures < 50000)
        numToExtract = numFeatures;
    end
    sel = randperm(numFeatures, numToExtract);
    features = features(sel, :);

    % k-means法で、代表ベクトル（visual word）を決まった数だけ選ぶ
    % この代表ベクトルの集合がコードブックとなる
    k = n;
    [~, codebook] = kmeans(features, k);
end
