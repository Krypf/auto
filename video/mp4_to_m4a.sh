#!/bin/bash

# 引数が指定されているか確認
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <target_directory>"
    exit 1
fi

# 引数をディレクトリとして受け取る
TARGET_DIR="$1"

# ディレクトリの存在確認
if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Directory '$TARGET_DIR' does not exist."
    exit 1
fi

# ディレクトリ内のMP4ファイルを処理
for file in "$TARGET_DIR"/*.mp4; do
    # ファイルが存在しない場合のチェック
    if [ ! -e "$file" ]; then
        echo "No MP4 files found in '$TARGET_DIR'."
        exit 0
    fi

    # 拡張子を除いたファイル名を取得
    base_name="$(basename "${file%.mp4}")"
    
    # 新しいM4AファイルをTARGET_DIRに生成
    new_file="$TARGET_DIR/$base_name.m4a"
    
    # ファイルの名前を変更（コピーを生成）
    cp -p "$file" "$new_file"
    echo "Generated: $new_file"
done

echo "All files processed in '$TARGET_DIR'!"
