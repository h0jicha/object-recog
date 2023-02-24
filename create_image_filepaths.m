% 指定されたディレクトリ内の画像ファイルのパス一覧を取得する
function file_paths = create_image_filepaths(directory_path)
    files = dir(directory_path);
    file_names = {files.name}';
    file_names = file_names(~ismember(file_names,{'.','..'}));
    file_paths = cell(size(file_names));
    for i = 1:numel(file_names)
        file_paths{i} = fullfile(directory_path, file_names{i});
    end
end
