--table 昏力
drop table userOrder_refund;
drop table userOrder_exchange;
drop table userOrder_detail;
drop table user_order;
drop table deliver_address;
drop table review_reply;
drop table product_review;
drop table userTable;
drop table cart;
drop table product_opt;
drop table product_d_img;
drop table product_t_img;
drop table product;

-- product/qna 昏力 --
drop sequence product_review_seq;
drop sequence review_reply_seq;
drop sequence product_seq;
drop sequence cart_seq;
drop sequence product_opt_seq;

drop sequence qna_seq;
drop sequence qna_reply_seq;
drop sequence notice_seq;

-- user/nonuser 昏力 --
drop sequence nonuserOrder_detail_seq;
drop sequence nonuserOrder_refund_seq;
drop sequence nonuserOrder_exchange_seq;
drop sequence nonuser_order_seq;

drop sequence userOrder_detail_seq;
drop sequence userOrder_refund_seq;
drop sequence user_idx_seq;
drop sequence user_order_seq;
drop sequence userOrder_exchange_idx;

-- product/qna 积己 --
create sequence product_review_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence review_reply_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence product_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence product_opt_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence cart_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;

create sequence qna_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence qna_reply_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence notice_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
------------------------------------------------------------------------

-- user/nonuser 积己 --
create sequence nonuserOrder_detail_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence nonuserOrder_refund_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence nonuserOrder_exchange_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence nonuser_order_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;

create sequence userOrder_detail_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence userOrder_refund_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence user_idx_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence user_order_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence userOrder_exchange_idx start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
---------------------------------------------------------------------------------------------------------------

-- user抛捞喉 积己 --

CREATE TABLE userTable (
	user_id	varchar2(30)	NOT NULL primary key,
	user_idx	number	DEFAULT user_idx_seq.nextval	NOT NULL,
	user_pwd	varchar2(255)		NOT NULL,
	user_name	varchar2(20)		NOT NULL,
	user_phone	varchar2(20)		NOT NULL,
	user_email	varchar2(50)		NOT NULL,
	email_check	varchar2(2)		NOT NULL,
	user_role	number		NOT NULL,
	user_grade	varchar2(10)		NOT NULL,
	user_insertDate	date	DEFAULT sysdate	NOT NULL
);

-- userOrder table 积己
CREATE TABLE user_order (
	user_order_idx	number	DEFAULT user_order_seq.nextval primary key,
	user_id	varchar2(30)	NOT NULL,
	order_date	date	DEFAULT sysdate 	NOT NULL,
	address1	varchar2(20)	NOT NULL,
	address2	varchar2(50)	NOT NULL,
	address3	varchar2(50)	NOT NULL,
	order_total_price	number	NOT NULL,
	receiver_name	varchar2(20)	NOT NULL,
	receiver_phone	varchar2(20)	NOT NULL,
	order_detail_status	varchar(20)	NOT NULL,
    
    constraint user_order_user
    foreign key(user_id)
    references userTable(user_id)
);
-- deliverAddress table 积己

CREATE TABLE deliver_address (
	user_id	varchar2(30)	NOT NULL,
	user_address1	varchar2(20)	NOT NULL,
	user_address2	varchar2(50)	NOT NULL,
	user_address3	varchar2(50)	NOT NULL,
    
    constraint deliver_address_userTable
    FOREIGN key(user_id)
    REFERENCES userTable(user_id)
);
--product table 积己
create table product (
    product_idx             number              default product_seq.nextval  primary key,
    product_code            varchar2(20)        not null,
    product_name            varchar2(50)        not null,
    product_price           number              not null,
    product_desc            varchar2(3000)      ,
    product_date            date                default sysdate not null,
    product_hits            number              default 0 not null,
    delete_check            varchar2(2)         default 'n' not null,
    show_check              varchar2(10)        default 'show' not null   
);

-- product 歹固涝仿
insert into product(product_code,product_name,product_price) values('m_top_1','棵单捞 海捞流 萍寂明 -馆迫 坷滚峭',24900);
insert into product(product_code,product_name,product_price) values('m_top_2','海捞流 饭捞绢靛 馆迫 萍寂明',12900);
insert into product(product_code,product_name,product_price) values('m_top_3','其宏腐 飘饭捞醋 饶靛',49900);
insert into product(product_code,product_name,product_price) values('m_top_4','某陵倔 饭磐傅 盖捧盖',32900);
insert into product(product_code,product_name,product_price) values('m_top_5','葛唱固 海捞流 盖捧盖',19900);
insert into product(product_code,product_name,product_price) values('m_top_6','孤令 海捞流 罗府 盖捧盖',27900);
insert into product(product_code,product_name,product_price) values('m_top_7','棵单捞 海捞流 萍寂明 -变迫 坷滚峭',24900);
insert into product(product_code,product_name,product_price) values('m_top_8','扼款靛 池 角南 萍寂明',19900);
insert into product(product_code,product_name,product_price) values('m_top_9','单老府 公瘤 氛浇府宏',17900);
insert into product(product_code,product_name,product_price) values('m_top_10','蜡池 匙抿凡 氛 浇府宏 萍寂明',19900);
insert into product(product_code,product_name,product_price) values('m_top_11','家橇飘 扼款靛 变迫萍',19900);
insert into product(product_code,product_name,product_price) values('m_top_12','敲贰粗 惯器 盖捧盖',44900);
insert into product(product_code,product_name,product_price) values('m_top_13','府滚钱 傅努橇府 扼款靛 变迫萍',12900);
insert into product(product_code,product_name,product_price) values('m_top_14','胶拍促靛 氛 浇府宏',16900);
insert into product(product_code,product_name,product_price) values('m_top_15','海捞流 公瘤 弃扼 萍寂明',27900);

--芥匙老 抛捞喉 积己
create table product_t_img (
    product_t_img           varchar2(100)            not null,
    product_idx             number                   not null,   
    
    constraint product_t_img_product
    foreign key(product_idx)
    references product(product_idx)
);

--惑技捞固瘤 抛捞喉 积己
create table product_d_img (
    product_d_img           varchar2(100)            not null,
    product_idx             number                   not null,   
    
    constraint product_d_img_product
    foreign key(product_idx)
    references product(product_idx)
);

--力前 可记 抛捞喉 积己
create table product_opt (
    product_opt_idx           number            default product_opt_seq.nextval  primary key,
    product_idx             number              not null,
    product_size            varchar2(50)        not null,
    product_color           varchar2(100)       not null,
    product_stock           number              default 0 not null,
    
    constraint product_opt_product
    foreign key(product_idx)
    references product(product_idx)
);

--厘官备聪 抛捞喉 积己
create table cart (
    cart_idx                number            default cart_seq.nextval  primary key,
    product_opt_idx         number            not null,
    cart_value              varchar2(30)      not null,
    product_count           number            default 0 not null, --力前荐樊牢单 0捞搁 救登唱?
    
    constraint cart_product_opt
    foreign key(product_opt_idx)
    references product_opt(product_opt_idx)
);

--力前府轰 抛捞喉 积己
create table product_review (
    product_review_idx         number           default product_review_seq.nextval  primary key,
    product_opt_idx            number           not null,
    user_id                    varchar2(30)     not null,
    rate                       number           not null,
    content                    varchar2(3000)   not null,
    writing_date               date             default sysdate not null,
    delete_check               varchar2(2)      default 'n' not null,
    
    constraint product_review_product_opt
    foreign key(product_opt_idx)
    references product_opt(product_opt_idx),
    
    constraint product_review_userTable
    foreign key(user_id)
    references userTable(user_id)
);

--府轰俊 翠臂 抛捞喉 积己
create table review_reply (
    review_reply_idx           number           default product_review_seq.nextval  primary key,
    product_review_idx         number           not null,
    content                    varchar2(30)     not null,
    writing_date               date             default sysdate not null,
    
    constraint review_reply_product_review
    foreign key(product_review_idx)
    references product_review(product_review_idx)
);
--userOrder_detail 抛捞喉 积己
CREATE TABLE userOrder_detail (
	userOrder_detail_idx	number DEFAULT userOrder_detail_seq.nextval primary key,
	product_opt_idx	number	not null,
	user_order_idx	number	not null,
	product_count	number	NOT NULL,
	product_price	number	NOT NULL,
    
    constraint userOrder_detail_opt_idx
    foreign key (product_opt_idx)
    REFERENCES product_opt(product_opt_idx),
    
    constraint userOrder_detail_user_order_idx
    foreign key (user_order_idx)
    REFERENCES user_order(user_order_idx)
);

--userOrder Refund 抛捞喉 积己

CREATE TABLE userOrder_refund (
	userOrder_refund_idx	number	DEFAULT userOrder_refund_seq.nextval primary key,
	userOrder_detail_idx	number	NOT NULL,
	refund_reason	varchar2(3000)	NOT NULL,
	reason_img	varchar2(300)	NOT NULL,
	userOrder_refund_status	varchar(50)	NOT NULL,
    
    constraint userOrder_refund_userOrder_detail
    FOREIGN key(userOrder_detail_idx)
    REFERENCES userOrder_detail(userOrder_detail_idx)
  
);

CREATE TABLE userOrder_exchange (
	userOrder_exchange_idx	number	DEFAULT userOrder_exchange_idx.nextval,
	userOrder_detail_idx	number	NOT NULL,
	exchange_reason	varchar2(3000)	NOT NULL,
	reason_img	varchar2(300)	NOT NULL,
	userOrder_exchange_status	varchar(50)	NOT NULL,
    
    constraint userOrder_exchange_userOrder_detail
    foreign key(userOrder_detail_idx)
    references userOrder_detail(userOrder_detail_idx)
);
--nonuser Order
CREATE TABLE nonuser_order (
	nonuser_order_idx	number	DEFAULT nonuser_order_seq.nextval primary key,
	order_date	date	DEFAULT sysdate	NOT NULL,
	address1	varchar2(20)		NOT NULL,
	address2	varchar2(50)		NOT NULL,
	address3	varchar2(50)		NOT NULL,
	receiver_name	varchar2(20)		NOT NULL,
	receiver_phone	varchar2(20)		NOT NULL,
	nonuser_order_status	varchar2(20)		NOT NULL,
    nonuser_pwd             varchar2(20)        NOT NULL
);
--nonuserOrder detail
CREATE TABLE nonuserOrder_detail (
	nonuserOrder_detail_idx	number	DEFAULT nonuserOrder_detail_seq.nextval primary key,
	product_opt_idx         	number	NOT NULL,
	nonuser_order_idx	    number  NOT NULL,
	
    product_count	number		NOT NULL,
	product_price	number		NOT NULL,
    
    constraint fk_nonuser_order  --  力距炼扒狼 捞抚
    foreign key(nonuser_order_idx)           --  寇贰虐啊瞪 拿烦
    REFERENCES nonuser_order(nonuser_order_idx),    --  寇贰虐啊 曼炼窍绰 抛捞喉 (拿烦)
           
    constraint fk_product_opt  --  力距炼扒狼 捞抚
    foreign key(product_opt_idx)           --  寇贰虐啊瞪 拿烦
    REFERENCES product_opt(product_opt_idx)    --  寇贰虐啊 曼炼窍绰 抛捞喉 (拿烦)
       --  何葛虐啊 昏力瞪 版快 贸府  // 惑前捞 力芭登搁 概免扒档 荤扼柳促.
);
--nonuserOrder_refund
CREATE TABLE nonuserOrder_refund (
	nonuserOrder_refund_idx	number	DEFAULT nonuserOrder_refund_seq.nextval primary key,
	nonuserOrder_detail_idx	number NOT NULL,
	refund_reason	varchar2(3000)		NOT NULL,
	reason_img	varchar2(300)		NOT NULL,
	user_email	varchar(50)		NOT NULL,

    constraint fk_nonuserOrder_detail  --  力距炼扒狼 捞抚
    foreign key(nonuserOrder_detail_idx)           --  寇贰虐啊瞪 拿烦
    REFERENCES nonuserOrder_detail(nonuserOrder_detail_idx)    --  寇贰虐啊 曼炼窍绰 抛捞喉 (拿烦)
);
--nonuserOrder_exchange
CREATE TABLE nonuserOrder_exchange (
	nonuserOrder_exchange_idx	number	DEFAULT nonuserOrder_exchange_seq.nextval primary key,
	nonuserOrder_detail_idx	number	DEFAULT nonuserOrder_detail_seq.nextval NOT NULL,
	exchange_reason	varchar2(3000)		NOT NULL,
	reason_img	varchar2(300)		NOT NULL,
	nonuserOrder_exchange_status	varchar(50)		NOT NULL,
    
     constraint fk_nonuserOrder_detail2  --  力距炼扒狼 捞抚
    foreign key(nonuserOrder_detail_idx)           --  寇贰虐啊瞪 拿烦
    REFERENCES nonuserOrder_detail(nonuserOrder_detail_idx)    --  寇贰虐啊 曼炼窍绰 抛捞喉 (拿烦)

);





