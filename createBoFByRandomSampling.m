% codebookに基づいて、filenamesに対応する各画像のbag-of-feature表現を得ます。
% ただし、特徴点抽出はrandom samplingによります。
function bof = createBoFByRandomSampling(codebook, filenames)
    n = size(filenames, 1);
    bof = zeros(n, size(codebook, 1));

    % 各画像についての for-loop
    for j = 1 : n
        % j番目の画像を読み込み、SURF特徴を抽出する
        I = rgb2gray(imread(filenames{j}));
        p = createRandomPoints(I, 1000); % random sampling
        [fts, p2] = extractFeatures(I,p);

        % 各特徴点についての for-loop
        for i=1:size(p2,1)
            % 一番近いcodebook中のベクトルを探してindexを求める．
            [~, simIndex] = searchMostSimilarVec(codebook, fts(i, :));
            % bofヒストグラム行列のj番目の画像のindexに投票
            bof(j, simIndex) = bof(j, simIndex) + 1;
        end
    end

    % sum(A,2)で行ごとの合計を求めて，それを各行の要素について割ることによっ
    % て，各行の合計値を１として正規化する． 
    bof = bof ./ sum(bof,2);  
end