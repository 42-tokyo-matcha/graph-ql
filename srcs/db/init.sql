-- 都道府県のENUM型を作成
CREATE TYPE prefecture AS ENUM (
    'Hokkaido', 'Aomori', 'Iwate', 'Miyagi', 'Akita', 'Yamagata', 'Fukushima',
    'Ibaraki', 'Tochigi', 'Gunma', 'Saitama', 'Chiba', 'Tokyo', 'Kanagawa',
    'Niigata', 'Toyama', 'Ishikawa', 'Fukui', 'Yamanashi', 'Nagano',
    'Gifu', 'Shizuoka', 'Aichi', 'Mie',
    'Shiga', 'Kyoto', 'Osaka', 'Hyogo', 'Nara', 'Wakayama',
    'Tottori', 'Shimane', 'Okayama', 'Hiroshima', 'Yamaguchi',
    'Tokushima', 'Kagawa', 'Ehime', 'Kochi',
    'Fukuoka', 'Saga', 'Nagasaki', 'Kumamoto', 'Oita', 'Miyazaki', 'Kagoshima', 'Okinawa'
);

-- 性別のENUM型を作成
CREATE TYPE gender_type AS ENUM ('male', 'female');

-- 性的指向のENUM型を作成
CREATE TYPE sexuality_type AS ENUM ('male', 'female', 'male/female');

-- userはuserの基本的な情報が入っているテーブル
CREATE TABLE IF NOT EXISTS user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL, -- hash化されたpassword

    lastname VARCHAR(50) NOT NULL DEFAULT '', -- 姓
    firstname VARCHAR(50) NOT NULL DEFAULT '', -- 名前
    birthdate DATE NOT NULL DEFAULT '2000-04-02', -- 生年月日
    --is_gps BOOLEAN DEFAULT FALSE, -- 位置情報を利用するか
    gender gender_type NOT NULL DEFAULT 'male', -- 性別
    sexuality sexuality_type NOT NULL DEFAULT 'male', -- 性的対象
    area prefecture NOT NULL DEFAULT 'Tokyo', -- 都道府県
    self_intro_text VARCHAR(300) NOT NULL DEFAULT '', -- 自己紹介
    
    image_path1 VARCHAR(255) DEFAULT NULL, /* プロフィール画像のパス */
    image_path2 VARCHAR(255) DEFAULT NULL, /* プロフィール画像のパス */
    image_path3 VARCHAR(255) DEFAULT NULL, /* プロフィール画像のパス */
    image_path4 VARCHAR(255) DEFAULT NULL, /* プロフィール画像のパス */
    image_path5 VARCHAR(255) DEFAULT NULL, /* プロフィール画像のパス */

    is_online BOOLEAN DEFAULT FALSE,
    is_registered BOOLEAN DEFAULT TRUE, -- is_registeredはsignup後にメールで認証したかどうかを表すものだが、開発の最初ではスピードを重視し、でふぉるとでtrue
    is_preparation BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS user_location (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user INT NOT NULL,
    location POINT NOT NULL DEFAULT (ST_GeomFromText('POINT(139.7454 35.6586)')), -- 東京タワーのデフォルト値
    location_alternative POINT NOT NULL DEFAULT (ST_GeomFromText('POINT(139.7454 35.6586)')), -- 東京タワーのデフォルト値
    is_gps BOOLEAN DEFAULT FALSE, -- 位置情報を利用するか
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    FOREIGN KEY (user) REFERENCES user(id) ON DELETE CASCADE,
    CONSTRAINT unique_user_location UNIQUE (user)
);
