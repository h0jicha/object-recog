% 画像ファイルパス列から、正規化済みカラーヒストグラム列DBを作成します。
function DB = generate_histograms(FN)
    DB = zeros(size(FN, 1), 64);
    my_norm = @(h) h / sum(h);
    for i=1:size(DB, 1)
        DB(i,:) = my_norm(image2hist(imread(FN{i})));
    end
end