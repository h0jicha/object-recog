function [acc, conf_mat, mdl] = two_class_classification(features, labels, classifier_type, num_folds)
    % 分割数に応じて分割する
    cv = cvpartition(labels, 'KFold', num_folds);
    
    % 精度と混同行列を格納する配列を用意する
    acc = zeros(cv.NumTestSets, 1);
    conf_mat = zeros(2, 2, cv.NumTestSets);

    for i = 1:cv.NumTestSets
        train_idx = cv.training(i);
        test_idx = cv.test(i);

        % 学習データとテストデータに分割する
        X_train = features(train_idx, :);
        y_train = labels(train_idx);
        X_test = features(test_idx, :);
        y_test = labels(test_idx);

        % 分類器を選択し、学習する
        switch classifier_type
            case 'linearSVM'
                mdl = fitcsvm(X_train, y_train);
            case 'nonlinearSVM'
                mdl = fitcsvm(X_train, y_train, 'KernelFunction', 'rbf', 'KernelScale', 'auto');
            case 'knn'
                mdl = fitcknn(X_train, y_train);
            otherwise
                error('Invalid classifier type');
        end
        
        % テストデータで評価する
        y_pred = predict(mdl, X_test);
        acc(i) = sum(y_pred == y_test) / numel(y_test);
        conf_mat(:, :, i) = confusionmat(y_test, y_pred);
    end
end