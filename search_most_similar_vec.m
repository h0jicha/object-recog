% vとの類似ベクトル検索をDBの各横ベクトルについて行い、最も類似するベクトルの情報を返す。
function [simV, simIndex] = search_most_similar_vec(DB, v)
    % DBの各横ベクトルとベクトルvとの各距離を、ベクトル化で求める
    n = size(DB, 1);
    A = DB;
    B = repmat(v, n, 1);
    distances = sqrt(sum((A-B).^2,2));

    [simV, simIndex] = min(distances);
end
