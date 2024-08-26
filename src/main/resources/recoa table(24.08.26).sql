drop table alarm;
drop table chat_file;
drop table chat;
drop table chat_room;
drop table note_file;
drop table note;
drop table utill_bill;
drop table reserve_guest;
drop table reserve_library;
drop table library;
drop table free_like;
drop table board_free_comment;
drop table board_free_img;
drop table board_free;
drop table board_notice_img;
drop table notice_bookmark;
drop table board_notice;
drop table user;

create table user(
	user_code INT PRIMARY KEY AUTO_INCREMENT,
    user_id VARCHAR(100),
    user_pwd VARCHAR(300),
    user_name VARCHAR(100),
    user_nickname VARCHAR(100),
    user_img_url VARCHAR(500),
    user_phone VARCHAR(13),
    user_adr VARCHAR(10),
    user_adr_detail VARCHAR(10),
    user_email VARCHAR(100),
    user_admin VARCHAR(10) DEFAULT 'user'
);

create table board_notice(
	notice_code INT PRIMARY KEY AUTO_INCREMENT,
    user_code INT,
    notice_title VARCHAR(100),
    notice_content TEXT,
    notice_writedate DATETIME DEFAULT CURRENT_TIMESTAMP,
    notice_view INT
);

create table board_notice_img(
	notice_img_code INT PRIMARY KEY AUTO_INCREMENT,
    notice_code INT,
    notice_img_url VARCHAR(500)
);

create table board_free(
   free_code INT PRIMARY KEY AUTO_INCREMENT,
    user_code INT,
    free_title VARCHAR(30),
    free_content TEXT,
    free_writedate timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    free_view INT default 0
);

create table board_free_img(
	free_img_code INT PRIMARY KEY AUTO_INCREMENT,
    free_code INT,
    free_img_url VARCHAR(500)
);

create table board_free_comment(
	free_comment_code INT PRIMARY KEY AUTO_INCREMENT,
    free_code INT,
    user_code INT,
    free_comment_content TEXT,
    free_comment_writedate timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    comment_parent_code INT
);

create table free_like(
	like_code INT PRIMARY KEY AUTO_INCREMENT,
    user_code INT,
    free_code INT
);

create table notice_bookmark(
	bookmark_code INT PRIMARY KEY AUTO_INCREMENT,
    user_code INT,
    notice_code INT
);

create table library(
	library_code INT PRIMARY KEY AUTO_INCREMENT,
    seat_code INT,
    status boolean DEFAULT true
);

create table reserve_library(
	reserve_lib_code INT PRIMARY KEY AUTO_INCREMENT,
    user_code INT,
    library_code INT,
    seat_code INT,
    start_time DATETIME,
    end_time DATETIME,
    regi_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status boolean DEFAULT false
);

create table reserve_guest(
	reserve_guest_code INT PRIMARY KEY AUTO_INCREMENT,
    user_code INT,
    room_type INT,
    room_code INT,
    start_time DATETIME,
    end_time DATETIME,
    regi_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status boolean default TRUE
);

create table utill_bill(
	bill_code INT PRIMARY KEY AUTO_INCREMENT,
	user_code INT,
    bill_year INT,
    bill_month INT,
    lib_use_period INT,
    lib_total_price INT,
    guest1_use_period INT,
    guest2_use_period INT,
    room_total_price INT,
    total_price INT
);

create table note(
	note_code INT PRIMARY KEY AUTO_INCREMENT,
    note_sender INT,
    note_receiver INT,
    note_title VARCHAR(30),
    note_content TEXT,
    note_writedate DATETIME DEFAULT CURRENT_TIMESTAMP,
    sender_delete boolean,
    receiver_delete boolean
);

create table note_file(
	note_file_code INT PRIMARY KEY AUTO_INCREMENT,
    note_code INT,
    note_file_url VARCHAR(500)
);

create table chat_room(
	chat_room_code INT PRIMARY KEY AUTO_INCREMENT,
    user_number1 INT,
    user_number2 INT
);

create table chat(
	chat_code INT PRIMARY KEY AUTO_INCREMENT,
    chat_message TEXT,
    chat_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    chat_room_code INT,
    user_number INT
);

create table chat_file(
	chat_file_code INT PRIMARY KEY AUTO_INCREMENT,
    chat_code INT,
    chat_file_url VARCHAR(500)
);

create table alarm(
	alarm_code INT PRIMARY KEY AUTO_INCREMENT,
    user_code INT,
    alarm_check boolean DEFAULT false,
    alarm_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    alarm_table VARCHAR(30),
    alarm_content TEXT,
    alarm_url VARCHAR(500)
);

-- user랑 연결
alter table board_notice add constraint foreign key(user_code) references user (user_code) ON DELETE CASCADE;
alter table board_free add constraint foreign key(user_code) references user (user_code) ON DELETE CASCADE;
alter table free_like add constraint foreign key(user_code) references user (user_code) ON DELETE CASCADE;
alter table notice_bookmark add constraint foreign key(user_code) references user (user_code) ON DELETE CASCADE;
alter table reserve_library add constraint foreign key(user_code) references user (user_code) ON DELETE CASCADE;
alter table reserve_guest add constraint foreign key(user_code) references user (user_code) ON DELETE CASCADE;
alter table utill_bill add constraint foreign key(user_code) references user (user_code) ON DELETE CASCADE;
alter table note add constraint sender_user foreign key(note_sender) references user (user_code) ON DELETE CASCADE;
alter table note add constraint receiver_user foreign key(note_receiver) references user (user_code) ON DELETE CASCADE;
alter table chat_room add constraint user1 foreign key(user_number1) references user (user_code) ON DELETE CASCADE;
alter table chat_room add constraint user2 foreign key(user_number2) references user (user_code) ON DELETE CASCADE;
alter table chat add constraint user_number foreign key(user_number) references user (user_code) ON DELETE CASCADE;
alter table alarm add constraint foreign key(user_code) references user (user_code) ON DELETE CASCADE;

-- board_notice랑 연결
alter table board_notice_img add constraint foreign key(notice_code) references board_notice (notice_code) ON DELETE CASCADE;
alter table notice_bookmark add constraint foreign key(notice_code) references board_notice (notice_code) ON DELETE CASCADE;

-- board_free랑 연결
alter table board_free_img add constraint foreign key(free_code) references board_free (free_code) ON DELETE CASCADE;
alter table board_free_comment add constraint foreign key(free_code) references board_free (free_code) ON DELETE CASCADE;
alter table free_like add constraint foreign key(free_code) references board_free (free_code) ON DELETE CASCADE;

-- library랑 연결
alter table reserve_library add constraint foreign key(library_code) references library (library_code) ON DELETE CASCADE;

-- note랑 연결
alter table note_file add constraint foreign key(note_code) references note (note_code) ON DELETE CASCADE;

-- chat_room이랑 연결
alter table chat add constraint foreign key(chat_room_code) references chat_room (chat_room_code) ON DELETE CASCADE;

-- chat이랑 연결
alter table chat_file add constraint foreign key(chat_code) references chat (chat_code) ON DELETE CASCADE;
