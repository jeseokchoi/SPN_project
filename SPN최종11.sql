--table 昏力
drop table qna_reply;
drop table qna;
drop table notice;
drop table userOrder_refund;
drop table userOrder_exchange;
drop table userOrder_detail;
drop table review_reply;
drop table product_review;
drop table user_order;
drop table deliver_address;
drop table userTable;
drop table cart;
drop table nonuserOrder_refund;
drop table nonuserOrder_exchange;
drop table nonuserOrder_detail;
drop table nonuser_order;
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
	user_email	varchar2(50)	    NOT NULL,
	email_check	varchar2(10)		check(email_check in('Y','N')) NOT NULL,
	user_role	varchar2(20)	    default 'user' check(user_role in('admin','user'))	NOT NULL,
	user_grade	varchar2(20)		default 'bronze' check(user_grade in('bronze','silver','gold')) not null,
	user_insertDate	date	        DEFAULT sysdate	NOT NULL,
    user_birth    date              NOT NULL,
    user_gender varchar2(20)        check(user_gender in('咯己','巢己')) NOT NULL
);

CREATE TABLE qna (
   qna_idx           number               default qna_seq.nextval  primary key,
   user_id           varchar2(30)      NOT NULL,
    qna_password    varchar2(100)       ,
    qna_title       varchar2(300)       not null,
    qna_content     varchar2(4000)      not null,
    qna_writeDate   date                default sysdate not null,
    qna_secret      varchar2(10)        default 'N' check(qna_secret in('Y','N')) NOT NULL,
    
    constraint qna_userTable
    foreign key(user_id)
    references userTable(user_id)
);

create table qna_reply (
    qna_reply_idx       number          default qna_reply_seq.nextval primary key,
    qna_idx             number          not null,
    content             varchar2(3000)  not null,
    writing_date        date            default sysdate not null,
    
    constraint qna_reply_qna
    foreign key(qna_idx)
    references qna(qna_idx)
);

create table notice (
    notice_idx          number          default notice_seq.nextval primary key,
    notice_writer       varchar2(100)   not null,
    notice_title        varchar2(300)   not null,
    notice_content      varchar2(4000)  not null,
    notice_writeDate    date            not null,
    show_check          varchar2(10)    default 'N' check(show_check in('Y', 'N')) not null
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
	order_detail_status	varchar(20) default '林巩犬牢吝',
    
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
    product_name            varchar2(200)        not null,
    product_price           number              not null,
    product_desc            varchar2(3000)      ,
    product_date            date                default sysdate not null,
    product_hits            number              default 0 not null,
    delete_check            varchar2(2)         default 'n' not null,
    show_check              varchar2(10)        default 'show' not null   
);

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
	userOrder_refund_status	varchar(50)	default '立荐肯丰',
    
    constraint userOrder_refund_userOrder_detail
    FOREIGN key(userOrder_detail_idx)
    REFERENCES userOrder_detail(userOrder_detail_idx)
  
);

CREATE TABLE userOrder_exchange (
	userOrder_exchange_idx	number	DEFAULT userOrder_exchange_idx.nextval,
	userOrder_detail_idx	number	NOT NULL,
	exchange_reason	varchar2(3000)	NOT NULL,
	reason_img	varchar2(300)	NOT NULL,
	userOrder_exchange_status	varchar(50) default '立荐肯丰',
    
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
    order_total_price number       NOT NULL,
	receiver_name	varchar2(20)		NOT NULL,
	receiver_phone	varchar2(20)		NOT NULL,                  
	nonuser_order_status	varchar2(50)		default '林巩犬牢吝' ,  
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
	nonuserOrder_refund_status	varchar2(50)		default '立荐肯丰',  -- 捞固瘤俊 email肺 登绢乐绢辑 弊犯霸 父甸菌菌澜.

    constraint fk_nonuserOrder_detail  --  力距炼扒狼 捞抚
    foreign key(nonuserOrder_detail_idx)           --  寇贰虐啊瞪 拿烦
    REFERENCES nonuserOrder_detail(nonuserOrder_detail_idx)    --  寇贰虐啊 曼炼窍绰 抛捞喉 (拿烦)
);
--nonuserOrder_exchange
CREATE TABLE nonuserOrder_exchange (
	nonuserOrder_exchange_idx	number	DEFAULT nonuserOrder_exchange_seq.nextval primary key,
	nonuserOrder_detail_idx	number NOT NULL,
	exchange_reason	varchar2(3000)		NOT NULL,
	reason_img	varchar2(300)		NOT NULL,
	nonuserOrder_exchange_status	varchar2(50)		default '立荐肯丰',-- 函版秦林绰 
    
    constraint fk_nonuserOrder_detail2  --  力距炼扒狼 捞抚
    foreign key(nonuserOrder_detail_idx)           --  寇贰虐啊瞪 拿烦
    REFERENCES nonuserOrder_detail(nonuserOrder_detail_idx)    --  寇贰虐啊 曼炼窍绰 抛捞喉 (拿烦)

);

insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('UnwtWO37','test1234!@','全巩枚','1982-01-13','巢己','010-3406-5339','UnwtWO37@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('fZrLdG95','test1234!@','脚己槛','2000-10-23','巢己','010-4961-6980','fZrLdG95@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('fwxLHU60','test1234!@','倾篮版','1995-02-02','巢己','010-7370-4980','fwxLHU60@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('CLeLwR82','test1234!@','碍快怕','1994-03-15','巢己','010-7613-2290','CLeLwR82@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('rlReFg93','test1234!@','傈疙宽','1996-01-22','巢己','010-6748-4697','rlReFg93@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('wzBsVc87','test1234!@','荤傍铰扁','1996-02-15','巢己','010-2986-4989','wzBsVc87@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('uWgSgq70','test1234!@','归堡龋','1995-01-04','巢己','010-6455-6164','uWgSgq70@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('pYHZAb59','test1234!@','畴侩枚','1999-12-02','巢己','010-2668-7560','pYHZAb59@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('dYzsUd66','test1234!@','冠铰辟','1981-08-07','巢己','010-4780-8207','dYzsUd66@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('zPVaYB33','test1234!@','炔沥酋','1997-01-04','巢己','010-7809-4157','zPVaYB33@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('YGshpn97','test1234!@','归疙急','1990-11-28','巢己','010-4554-7828','YGshpn97@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('dUteJB40','test1234!@','救悼后','1987-07-06','巢己','010-4124-7184','dUteJB40@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('KgcCXs43','test1234!@','幅瓤刮','2002-09-13','巢己','010-8742-7149','KgcCXs43@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('EOHmJC56','test1234!@','巢捍窍','1995-11-01','巢己','010-8857-2235','EOHmJC56@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('DMKnnD87','test1234!@','己蜡柳','1992-10-22','巢己','010-3188-6252','DMKnnD87@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('nZeBmC16','test1234!@','救秦老','1984-10-26','巢己','010-7297-2181','nZeBmC16@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('gpLvvj41','test1234!@','畴泅版','1997-07-27','巢己','010-3823-4594','gpLvvj41@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('rHtSTI72','test1234!@','幅霖侩','1988-11-16','巢己','010-7755-7016','rHtSTI72@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('cvsxVu92','test1234!@','巢辣霖','1988-02-05','巢己','010-2900-2104','cvsxVu92@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('zDiPIW83','test1234!@','归己龋','1999-02-01','巢己','010-3525-1417','zDiPIW83@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('wwTnsG55','test1234!@','幅全扁','1991-10-07','巢己','010-8205-7510','wwTnsG55@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('ScePkt52','test1234!@','豪蜡柳','1980-10-13','巢己','010-7939-7426','ScePkt52@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('WKwBhF62','test1234!@','茄篮窍','1995-07-27','巢己','010-4782-8225','WKwBhF62@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('OWrOwJ79','test1234!@','荤傍辣沥','1984-08-05','巢己','010-5717-2165','OWrOwJ79@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('IHgEAW25','test1234!@','捞怕籍','1991-11-01','巢己','010-3082-7436','IHgEAW25@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('XcSZni35','test1234!@','巩技柳','1995-06-12','巢己','010-7609-1522','XcSZni35@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('NcSBdD29','test1234!@','辫籍林','1990-12-10','巢己','010-9564-2632','NcSBdD29@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('SrsSEL34','test1234!@','硅篮快','2003-06-05','巢己','010-5998-8609','SrsSEL34@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('glhJAQ84','test1234!@','力哎疙槛','1999-03-29','巢己','010-4668-3799','glhJAQ84@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('sjKXlm25','test1234!@','幅泅怕','1987-01-28','巢己','010-5932-3426','sjKXlm25@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('WsjgUg67','test1234!@','炔犁挤','1981-06-11','咯己','010-5540-9783','WsjgUg67@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('dwPlKf63','test1234!@','硅枚鉴','2000-01-02','咯己','010-8854-9691','dwPlKf63@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('IUBYjr86','test1234!@','炔焊版备','1997-12-12','咯己','010-4712-4447','IUBYjr86@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('xoFTmj2','test1234!@','沥枚鉴','1980-10-03','咯己','010-2238-8198','xoFTmj2@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('gBOxjO33','test1234!@','眠公凯','1990-02-15','咯己','010-5257-7485','gBOxjO33@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('oNaynr78','test1234!@','浅泅铰','1988-08-20','巢己','010-1050-7727','oNaynr78@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('EzMXPG3','test1234!@','沥犁裹','1992-11-06','巢己','010-2058-1385','EzMXPG3@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('kLUpoq33','test1234!@','窍堡炼','2003-03-09','巢己','010-9459-9410','kLUpoq33@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('pZEoCz88','test1234!@','炔枚鉴','1994-12-18','巢己','010-8736-9845','pZEoCz88@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('DrOGnG62','test1234!@','畴傣荐','1992-08-16','巢己','010-8841-2706','DrOGnG62@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('VTOjAT49','test1234!@','捞泅铰','1980-06-07','咯己','010-3157-2462','VTOjAT49@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('XJyCZZ61','test1234!@','辑悼扒','1992-05-07','咯己','010-6514-2237','XJyCZZ61@naver.com','N','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('fcrovy98','test1234!@','巩犁裹','1984-01-20','咯己','010-7699-4335','fcrovy98@naver.com','N','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('EItSUp52','test1234!@','沥碍刮','1992-12-17','咯己','010-8484-6762','EItSUp52@naver.com','N','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('eDpBpw6','test1234!@','殴公凯','1980-09-06','咯己','010-9802-4978','eDpBpw6@naver.com','N','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('wYhyME2','test1234!@','炔犁挤','1980-03-05','巢己','010-2615-7301','wYhyME2@naver.com','N','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('JKHESW34','test1234!@','沥版琶','1998-10-12','巢己','010-5931-8894','JKHESW34@naver.com','N','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('ovRTAz44','test1234!@','厘版琶','1986-02-05','巢己','010-1239-2884','ovRTAz44@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('CsoHlu97','test1234!@','傈碍刮','1985-06-10','巢己','010-7768-6226','CsoHlu97@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('vZCDbi97','test1234!@','救摹盔','1985-03-14','巢己','010-6681-3192','vZCDbi97@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('VTEKpP32','test1234!@','巢泵版备','1994-04-28','巢己','010-3702-6600','VTEKpP32@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('trOGTA24','test1234!@','傈悼扒','1988-12-27','巢己','010-3486-8016','trOGTA24@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('nKpupq15','test1234!@','沥悼扒','1997-10-07','巢己','010-3028-4986','nKpupq15@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('hESTaB30','test1234!@','眠犁挤','1994-04-18','巢己','010-4660-7437','hESTaB30@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('baNJKX15','test1234!@','剧老己','1990-02-09','巢己','010-9714-6232','baNJKX15@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('kEAtoR65','test1234!@','绊铰清','1993-11-24','巢己','010-9618-1601','kEAtoR65@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('wvDnWb84','test1234!@','碍公康','2002-10-05','巢己','010-6039-6605','wvDnWb84@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('WJueMS21','test1234!@','巢泵摹盔','1982-07-09','巢己','010-1676-2820','WJueMS21@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('ogFdTo20','test1234!@','畴摹盔','1988-02-25','巢己','010-6673-8114','ogFdTo20@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('AzPciG70','test1234!@','汲摹盔','1981-04-20','巢己','010-9465-5905','AzPciG70@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('WzUdCc60','test1234!@','碍家扼','1999-11-02','巢己','010-3267-3406','WzUdCc60@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('mjRDRm11','test1234!@','己儡叼','1984-10-19','巢己','010-7049-4904','mjRDRm11@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('lAujbT96','test1234!@','捞穿府','1983-07-25','巢己','010-3273-8734','lAujbT96@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('kztVZt81','test1234!@','巢唱扼蝴','1999-02-27','巢己','010-9100-6374','kztVZt81@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('xrdGjI5','test1234!@','豪焊恩','1991-04-09','巢己','010-5409-6290','xrdGjI5@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('mheOMS15','test1234!@','钎酒氛','2002-11-14','巢己','010-6144-8937','mheOMS15@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('HMWkJe42','test1234!@','厘捞浇','1990-08-11','巢己','010-6694-1143','HMWkJe42@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('SVtlop17','test1234!@','弥家府','1981-03-08','巢己','010-3639-9093','SVtlop17@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('dnRFMX55','test1234!@','炔窍风','1994-07-09','咯己','010-8004-9226','dnRFMX55@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('ArzZSm10','test1234!@','辣磊恩','1993-04-10','咯己','010-9396-9807','ArzZSm10@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('MZvhZi26','test1234!@','眠唱厚','1984-02-13','咯己','010-7436-1360','MZvhZi26@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('zPGuUK34','test1234!@','蜡唱府','1986-09-12','咯己','010-3822-1037','zPGuUK34@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('qVNwgH95','test1234!@','汲酒抚','1994-07-24','咯己','010-4563-1151','qVNwgH95@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('oYAqbb1','test1234!@','辑刮甸饭','2003-01-20','咯己','010-4149-8492','oYAqbb1@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('jdAuXP97','test1234!@','脚啊恩','1985-05-26','咯己','010-5869-3910','jdAuXP97@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('XaCPzj99','test1234!@','硅焊恩','1995-11-06','咯己','010-3160-4273','XaCPzj99@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('HeNkgE81','test1234!@','捞茄基','1997-06-14','咯己','010-9240-5753','HeNkgE81@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('tVXDXC30','test1234!@','厘酒扼','1981-05-28','咯己','010-8671-6440','tVXDXC30@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('LStNSZ90','test1234!@','归贾','1995-11-25','咯己','010-9553-7800','LStNSZ90@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('ernGLF68','test1234!@','豪寝蝴','1980-05-11','咯己','010-7139-8494','ernGLF68@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('kdqLJe48','test1234!@','颊扁惠','1990-04-28','咯己','010-3777-7355','kdqLJe48@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('pkOCwk5','test1234!@','价滴府','1986-04-30','咯己','010-1605-4019','pkOCwk5@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('yoztKG24','test1234!@','巩付澜','1999-03-01','咯己','010-7310-5059','yoztKG24@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('HUTEIN97','test1234!@','辣篮基','1997-05-22','咯己','010-2742-3865','HUTEIN97@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('hIbeRR98','test1234!@','价备浇','1990-03-07','咯己','010-2273-5457','hIbeRR98@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('qolOaA24','test1234!@','幅滴府','2001-06-15','咯己','010-4129-7501','qolOaA24@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('jqfSLv55','test1234!@','沥啊恩','1993-12-07','咯己','010-9370-3448','jqfSLv55@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('xifHmX30','test1234!@','眠檬氛','1994-05-01','咯己','010-8988-6212','xifHmX30@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('iuXvxb50','test1234!@','力哎窍疵','1981-04-24','咯己','010-5569-7525','iuXvxb50@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('JpyLGs26','test1234!@','傈基唱','1995-01-30','咯己','010-7722-3077','JpyLGs26@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('onOzMc39','test1234!@','炼促款','1989-09-24','咯己','010-3288-1088','onOzMc39@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('zoraHk37','test1234!@','坷塞蛮','1996-01-08','咯己','010-1835-1894','zoraHk37@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('FvLCIa13','test1234!@','豪基','1999-01-04','咯己','010-8519-4797','FvLCIa13@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('YBKnXk66','test1234!@','辑茄辨','1998-06-11','咯己','010-4580-6266','YBKnXk66@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('prCLTb96','test1234!@','畴固福','1986-03-26','咯己','010-8895-5334','prCLTb96@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('MtUdiA8','test1234!@','巢泵唱辨','1989-02-07','咯己','010-1463-2478','MtUdiA8@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('FvDhzH99','test1234!@','辣固福','1994-10-27','咯己','010-3061-4499','FvDhzH99@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('FwGLoS28','test1234!@','豪塞蛮','1997-04-09','咯己','010-3923-9786','FwGLoS28@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('bOuIGy97','test1234!@','汲促款','1980-06-22','咯己','010-9356-2723','bOuIGy97@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('ixAXRA11','test1234!@','窍瓜澜','1998-01-06','咯己','010-5088-4523','ixAXRA11@naver.com','Y','user','bronze');

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
insert into product(product_code,product_name,product_price) values('m_top_16','府滚胶 坷滚 盖捧盖',34900);
insert into product(product_code,product_name,product_price) values('m_top_17','海捞流 飘困胶飘 坷滚变迫萍',34900);
insert into product(product_code,product_name,product_price) values('m_top_18','8color 单老府 馆弃扼 聪飘萍',32900);
insert into product(product_code,product_name,product_price) values('m_top_19','单老府 皑藕 萍寂明',15900);
insert into product(product_code,product_name,product_price) values('m_top_20','扁葛 氛 浇府宏 - 2瞒 府坷歹',21900);
insert into product(product_code,product_name,product_price) values('m_top_21','海捞流 扼款靛 变迫 萍寂明 [酒胶挪盔窜]',29900);
insert into product(product_code,product_name,product_price) values('m_top_22','海捞流 迄抛 变迫萍',24900);
insert into product(product_code,product_name,product_price) values('m_top_23','4color 窍橇池 聪飘萍',29900);
insert into product(product_code,product_name,product_price) values('m_shoes_1','2color 府倔 饭歹 喉肺欺(家啊磷)',56800);
insert into product(product_code,product_name,product_price) values('m_shoes_2','2color 攫闺繁胶 浇府欺',82800);
insert into product(product_code,product_name,product_price) values('m_shoes_3','3color 内瓢胶飘乏 敲赋敲而',42800);
insert into product(product_code,product_name,product_price) values('m_shoes_4','酒老阀 歹厚 努府欺',52800);
insert into product(product_code,product_name,product_price) values('m_shoes_5','春飘凡 胶聪目令',49800);
insert into product(product_code,product_name,product_price) values('m_shoes_6','器牢飘 胶涅绢配 饭歹 歹厚 酱令',64800);
insert into product(product_code,product_name,product_price) values('m_shoes_7','府倔饭歹 咆胶媚 胶聪目令',101800);
insert into product(product_code,product_name,product_price) values('m_shoes_8','坷凋 饭歹 其聪肺欺',58000);
insert into product(product_code,product_name,product_price) values('m_shoes_9','胶萍摹 浇复 喉发 肺欺',117000);
insert into product(product_code,product_name,product_price) values('m_shoes_10','击歹 每矫何明',56000);
insert into product(product_code,product_name,product_price) values('m_shoes_11','繁绢 皋浆 胶聪目令',131000);
insert into product(product_code,product_name,product_price) values('m_shoes_12','固聪钢 刀老焙 胶聪目令',54000);
insert into product(product_code,product_name,product_price) values('m_shoes_13','肺捞靛 瘤欺 牡滚胶',44000);
insert into product(product_code,product_name,product_price) values('m_shoes_14','宏坊令 每矫何明',59900);
insert into product(product_code,product_name,product_price) values('m_shoes_15','饭歹 歹厚 努府欺',149000);
insert into product(product_code,product_name,product_price) values('m_shoes_16','其府 胶涅绢配 肺欺',64000);
insert into product(product_code,product_name,product_price) values('m_shoes_17','SS 胶萍摹 歹厚 酱令',59900);
insert into product(product_code,product_name,product_price) values('m_shoes_18','海捞流 其聪肺欺 - 3瞒 府坷歹',57900);
insert into product(product_code,product_name,product_price) values('m_shoes_19','胶萍摹 歹厚 肺欺',59900);
insert into product(product_code,product_name,product_price) values('m_shoes_20','CP 海捞流 肺快 胶聪目令(拳捞飘) - 5瞒 府坷歹',39900);
insert into product(product_code,product_name,product_price) values('m_shirts_1','敲饭牢 内瓢 寂明',39900);
insert into product(product_code,product_name,product_price) values('m_shirts_2','固聪钢 坷滚 墨扼 寂明',42900);
insert into product(product_code,product_name,product_price) values('m_shirts_3','葛带 农酚 寂明',44900);
insert into product(product_code,product_name,product_price) values('m_shitrs_4','单老府 鸥藕 眉农 寂明',24900);
insert into product(product_code,product_name,product_price) values('m_shirts_5','Basic 内瓢 寂明',45900);
insert into product(product_code,product_name,product_price) values('m_shirts_6','饭捞 浇反单丛 寂明',44900);
insert into product(product_code,product_name,product_price) values('m_shirts_7','风捞胶 固聪钢 寂明',34900);
insert into product(product_code,product_name,product_price) values('m_shirts_8','技捞令 器敲赴 寂明',29900);
insert into product(product_code,product_name,product_price) values('m_shirts_9','缴敲 洒电 寂明',27900);
insert into product(product_code,product_name,product_price) values('m_shirts_10','6color 胶拍促靛 寂明',32900);
insert into product(product_code,product_name,product_price) values('m_shirts_11','9color 傅努橇府 坷滚 寂明',24900);
insert into product(product_code,product_name,product_price) values('m_shirts_12','7color 傅努橇府 缴敲 寂明',22900);
insert into product(product_code,product_name,product_price) values('m_shirts_13','缴敲 傅努橇府 寂明',24900);
insert into product(product_code,product_name,product_price) values('m_shirts_14','海捞流 苛胶器靛 寂明(变迫鸥涝)',21900);
insert into product(product_code,product_name,product_price) values('m_shirts_15','海捞流 胶鸥老矾 寂明',24900);
insert into product(product_code,product_name,product_price) values('m_shirrs_16','9color 傅努橇府 洒电 寂明',24900);
insert into product(product_code,product_name,product_price) values('m_shirts_17','概聪 贾府靛 坷滚寂明',27900);
insert into product(product_code,product_name,product_price) values('m_shirts_18','副泛胶 傅努橇府 寂明(变迫鸥涝)',24900);
insert into product(product_code,product_name,product_price) values('m_shirts_19','海捞流 傅努橇府 缴敲 寂明',24900);
insert into product(product_code,product_name,product_price) values('m_pants_1','5color 内瓢 龟爹 埔明',39900);
insert into product(product_code,product_name,product_price) values('m_pants_2','窍快胶 刨记 浇发胶 (备辫规瘤/洒电龟爹)',39900);
insert into product(product_code,product_name,product_price) values('m_pants_3','其宏腐 飘饭捞醋 埔明',44900);
insert into product(product_code,product_name,product_price) values('m_pants_4','巧盼 匡 客捞靛 浇发胶',44900);
insert into product(product_code,product_name,product_price) values('m_pants_5','盔盼 饭敝矾 扁葛 浇发胶',44900);
insert into product(product_code,product_name,product_price) values('m_pants_6','AW 技固 胶魄 龟爹 浇发胶',34900);
insert into product(product_code,product_name,product_price) values('m_pants_7','肺坊 抛捞欺靛 内瓢埔明',39900);
insert into product(product_code,product_name,product_price) values('m_pants_8','单老府 葛带 匡 浇发胶',39900);
insert into product(product_code,product_name,product_price) values('m_pants_9','葛带 客捞靛 浇发胶',47900);
insert into product(product_code,product_name,product_price) values('m_pants_10','单老府 胶拍促靛 单丛',49900);
insert into product(product_code,product_name,product_price) values('m_pants_11','3color 农覆 匙抿凡 单丛',49900);
insert into product(product_code,product_name,product_price) values('m_pants_12','蜡聪 内瓢 摹畴 埔明',32900);
insert into product(product_code,product_name,product_price) values('m_pants_13','葛唱农 浇发胶',47900);
insert into product(product_code,product_name,product_price) values('m_pants_14','肺飘 捧盼 客捞靛 浇发胶',29900);
insert into product(product_code,product_name,product_price) values('m_pants_15','坷福 胶魄 浇发胶',34900);
insert into product(product_code,product_name,product_price) values('m_pants_16','蜡令 技固客捞靛 浇发胶',37900);
insert into product(product_code,product_name,product_price) values('m_pants_17','肺怪 盔盼 胶焽埔明',44900);
insert into product(product_code,product_name,product_price) values('m_pants_18','橇肺弊 客捞靛 浇发胶',49900);
insert into product(product_code,product_name,product_price) values('m_pants_19','胶萍令 客捞靛 浇发胶',34900);
insert into product(product_code,product_name,product_price) values('m_pants_20','2color 努贰侥 眉农 浇发胶',45900);
insert into product(product_code,product_name,product_price) values('m_pants_21','肺刚 飘烙 单丛埔明 - BLACK',52900);
insert into product(product_code,product_name,product_price) values('m_pants_22','风矫 概流 龟爹 浇发胶',34900);
insert into product(product_code,product_name,product_price) values('m_pants_23','剐府 客捞靛 单丛埔明',34900);
insert into product(product_code,product_name,product_price) values('m_pants_24','福浚蠢 客捞靛 流扁 浇发胶',39900);
insert into product(product_code,product_name,product_price) values('m_pants_25','窍橇 坷滚 巧盼 埔明',49900);
insert into product(product_code,product_name,product_price) values('m_pants_26','羔瓢 内掂肺捞 龟爹埔明',24900);
insert into product(product_code,product_name,product_price) values('m_pants_27','矫农复 龟爹 浇发胶',34900);
insert into product(product_code,product_name,product_price) values('m_pants_28','府靛 糠飘烙 客捞靛 浇发胶',29900);
insert into product(product_code,product_name,product_price) values('m_pants_29','单固瘤 胶飘饭捞飘 力肺 单丛 by showpin (目泼鸥涝)',49900);
insert into product(product_code,product_name,product_price) values('m_pants_30','畴福雕 内瓢 埔明',37900);
insert into product(product_code,product_name,product_price) values('m_pants_31','傀胶畔 龟爹 内瓢埔明',34900);
insert into product(product_code,product_name,product_price) values('m_pants_32','贾府靛 技固客捞靛 浇发胶',32900);
insert into product(product_code,product_name,product_price) values('m_pants_33','葛胶飘 海捞流 浇发胶',29900);
insert into product(product_code,product_name,product_price) values('m_outer_1','鞘郊 坷滚 喉饭捞历',94900);
insert into product(product_code,product_name,product_price) values('m_outer_2','付老靛 饶靛 痢欺',39900);
insert into product(product_code,product_name,product_price) values('m_outer_3','坷胶墨 乔浆抛老 具惑菩爹',99000);
insert into product(product_code,product_name,product_price) values('m_outer_4','海捞流 缴敲 亲傍 痢欺',44900);
insert into product(product_code,product_name,product_price) values('m_outer_5','奶瓢 聪飘 墨扼 磊南',59900);
insert into product(product_code,product_name,product_price) values('m_outer_6','肺叼 坷滚峭 啊叼扒 (~3XL)',29900);
insert into product(product_code,product_name,product_price) values('m_outer_7','俊福 匡 歹喉 内飘',89900);
insert into product(product_code,product_name,product_price) values('m_outer_8','俊福 匡 教臂 内飘',89900);
insert into product(product_code,product_name,product_price) values('m_outer_9','副泛胶靛 匡 某矫 磊南',89900);
insert into product(product_code,product_name,product_price) values('m_outer_10','贾府靛 匡 某矫固绢 坷滚 教臂 内飘',109000);
insert into product(product_code,product_name,product_price) values('m_outer_11','8color 努贰侥 技固坷滚 磊南',79900);
insert into product(product_code,product_name,product_price) values('m_outer_12','捧器南 侵骂 扼款靛 笼诀',59900);
insert into product(product_code,product_name,product_price) values('m_outer_13','AW 贾府靛 教臂 磊南',79000);
insert into product(product_code,product_name,product_price) values('m_outer_14','橇坊 聪飘 窍橇笼诀',39900);
insert into product(product_code,product_name,product_price) values('m_outer_15','蜡聪 国烽 磊南',57900);
insert into product(product_code,product_name,product_price) values('m_outer_16','橇坊 聪飘 钱笼诀',39900);
insert into product(product_code,product_name,product_price) values('m_outer_17','14color 海捞流 某林倔 啊叼扒',39900);
insert into product(product_code,product_name,product_price) values('m_outer_18','AW 匡 某矫固绢 教臂/歹喉 内飘',99000);
insert into product(product_code,product_name,product_price) values('m_outer_19','单老府 坷滚 飘坊摹 内飘',72900);
insert into product(product_code,product_name,product_price) values('m_outer_20','宏肺牢 3滚瓢 教臂 内飘',69900);
insert into product(product_code,product_name,product_price) values('m_knit_1','家橇飘 滚瓢池 某矫 聪飘',39900);
insert into product(product_code,product_name,product_price) values('m_knit_2','饭唱 缴敲 usa 聪飘',39900);
insert into product(product_code,product_name,product_price) values('m_knit_3','2 Type 磐撇池 扼款靛 聪飘 - 2瞒 府坷歹',24900);
insert into product(product_code,product_name,product_price) values('m_knit_4','坷浇肺 滚瓢 磐撇池 聪飘',39900);
insert into product(product_code,product_name,product_price) values('m_knit_5','钢萍 纳捞喉 宏捞池 聪飘',39900);
insert into product(product_code,product_name,product_price) values('m_knit_6','某矫 海捞流 扼款靛聪飘',44900);
insert into product(product_code,product_name,product_price) values('m_knit_7','海福聪 窍橇笼诀 聪飘',44900);
insert into product(product_code,product_name,product_price) values('m_knit_8','葛绢 扼款靛池 聪飘',44900);
insert into product(product_code,product_name,product_price) values('m_knit_9','努肺捞 风令 飘烙 聪飘',29900);
insert into product(product_code,product_name,product_price) values('m_knit_10','缴敲府 扼款靛 聪飘',34900);
insert into product(product_code,product_name,product_price) values('m_knit_11','某矫 纳捞喉 扼款靛 聪飘',44900);
insert into product(product_code,product_name,product_price) values('m_knit_12','厚浚蠢 V池 聪飘',34900);
insert into product(product_code,product_name,product_price) values('m_knit_13','舅坊 坷锹池 聪飘',34900);
insert into product(product_code,product_name,product_price) values('m_knit_14','傀捞 榜瘤 某矫 弃扼聪飘',44900);
insert into product(product_code,product_name,product_price) values('m_knit_15','贾府靛 客敲 聪飘 - 2瞒 府坷歹',24900);
insert into product(product_code,product_name,product_price) values('m_knit_16','家橇飘 葛庆绢 墨扼聪飘',57900);
insert into product(product_code,product_name,product_price) values('m_knit_17','家橇飘 窍橇弃扼 聪飘萍',19900);
insert into product(product_code,product_name,product_price) values('m_knit_18','饭捞 胶拍促靛 扼款靛 聪飘',29900);
insert into product(product_code,product_name,product_price) values('m_knit_19','胶拍促靛 救萍鞘傅 聪飘萍 (焊钱规瘤)',32900);
insert into product(product_code,product_name,product_price) values('m_knit_20','饭捞 胶拍促靛 窍橇池 聪飘',29900);
insert into product(product_code,product_name,product_price) values('m_knit_21','客敲 缴敲府 聪飘',27900);
insert into product(product_code,product_name,product_price) values('w_bottom_1','矾弛 客捞靛 赴迟 浇发胶',29900);
insert into product(product_code,product_name,product_price) values('w_bottom_10','2 Type 骇虐 窍捞傀胶飘 浇发胶 (~4XL)',29900);
insert into product(product_code,product_name,product_price) values('w_bottom_11','饭橇呈 胶飘饭捞飘峭 单丛 (洒电龟爹)',27900);
insert into product(product_code,product_name,product_price) values('w_bottom_2','饭固 A扼牢 胶目飘',19900);
insert into product(product_code,product_name,product_price) values('w_bottom_3','府浚 技固客捞靛 内瓢埔明',21900);
insert into product(product_code,product_name,product_price) values('w_bottom_4','海凡 胶魄 农酚 何明钠',32000);
insert into product(product_code,product_name,product_price) values('w_bottom_5','扼捞橇 农酚 浇覆 埔明',29900);
insert into product(product_code,product_name,product_price) values('w_bottom_6','其齿 捧滚瓢 窍捞傀胶飘 何明钠',27900);
insert into product(product_code,product_name,product_price) values('w_bottom_7','饭橇呈 浇覆峭 单丛 (洒电龟爹)',27900);
insert into product(product_code,product_name,product_price) values('w_bottom_8','力畴宏 盔盼 客捞靛 浇发胶',27900);
insert into product(product_code,product_name,product_price) values('w_bottom_9','孤鸥 缔龟爹 客捞靛 浇发胶',29900);
insert into product(product_code,product_name,product_price) values('w_knit_1','羔肺快 扼款靛 馆迫 聪飘',19000);
insert into product(product_code,product_name,product_price) values('w_knit_2','羔肺快 宏捞池 馆迫 聪飘',19900);
insert into product(product_code,product_name,product_price) values('w_knit_3','肺厚酒 榜瘤 啊叼扒',24900);
insert into product(product_code,product_name,product_price) values('w_outer_1','海匙 墨扼 硅祸 啊叼扒',34900);
insert into product(product_code,product_name,product_price) values('w_outer_2','捞宏 墨扼 聪飘笼诀',37900);
insert into product(product_code,product_name,product_price) values('w_outer_3','饭萍 胶飘扼捞橇 扼款靛 啊叼扒',39900);
insert into product(product_code,product_name,product_price) values('w_outer_4','胶涅绢 宏捞池 榜瘤 啊叼扒',21900);
insert into product(product_code,product_name,product_price) values('w_outer_5','肺厚酒 榜瘤 啊叼扒',24900);
insert into product(product_code,product_name,product_price) values('w_shirts_1','迫饭靛 缔 浇复 喉扼快胶',21900);
insert into product(product_code,product_name,product_price) values('w_shirts_2','迫饭靛 坷滚峭 氛 喉扼快胶',21900);
insert into product(product_code,product_name,product_price) values('w_shirts_3','矫酒 寂傅 傅努橇府 喉扼快胶',24900);
insert into product(product_code,product_name,product_price) values('m_suit_1','AW 贾府靛 教臂 荐飘 (葛带鸥涝/洒电龟爹)',99000);
insert into product(product_code,product_name,product_price) values('m_suit_10','鞘郊 坷滚 教臂 荐飘',129000);
insert into product(product_code,product_name,product_price) values('m_suit_11','副泛胶靛 匡 某矫 荐飘',119000);
insert into product(product_code,product_name,product_price) values('m_suit_12','AW 贾府靛 教臂 荐飘 (洒电龟爹)',99000);
insert into product(product_code,product_name,product_price) values('m_suit_2','2color 努贰侥 眉农 荐飘',129000);
insert into product(product_code,product_name,product_price) values('m_suit_3','AW 技固 坷滚 胶魄 荐飘',109000);
insert into product(product_code,product_name,product_price) values('m_suit_4','宏贰胶 胶魄 教臂 荐飘',99000);
insert into product(product_code,product_name,product_price) values('m_suit_5','副泛胶 AW 贾府靛 荐飘 (胶飘饭摹盔窜/洒电龟爹)',109000);
insert into product(product_code,product_name,product_price) values('m_suit_6','奇靛 捧滚瓢 荐飘',109000);
insert into product(product_code,product_name,product_price) values('m_suit_7','AW 贾府靛 教臂 荐飘 (缴敲鸥涝/洒电龟爹)',99000);
insert into product(product_code,product_name,product_price) values('m_suit_8','风矫 教臂 荐飘',99000);
insert into product(product_code,product_name,product_price) values('m_suit_9','坷福 胶魄 教臂 荐飘',109000);
insert into product(product_code,product_name,product_price) values('w_top_1','乔匙明 榜瘤 扼款靛 馆迫萍',12900);
insert into product(product_code,product_name,product_price) values('w_top_2','单捞瘤 窍橇池 馆迫萍',11900);
insert into product(product_code,product_name,product_price) values('w_top_3','抛聪 扼款靛 庆府萍',14900);
insert into product(product_code,product_name,product_price) values('w_top_4','府郡 榜瘤 扼款靛 变迫萍',12900);
insert into product(product_code,product_name,product_price) values('w_top_5','坊蠢 榜瘤 U池 变迫萍',12900);
insert into product(product_code,product_name,product_price) values('w_top_6','胶橇傅 胶飘扼捞橇 变迫萍',12900);
insert into product(product_code,product_name,product_price) values('w_top_7','固蜡 浇覆 氛浇府宏萍',16900);
insert into product(product_code,product_name,product_price) values('w_top_7','海聪 家橇飘 榜瘤 弃扼萍',17900);



insert into product_d_img values('m_knit_1_d_1.jpg',116);
insert into product_d_img values('m_knit_10_d_1.jpg',125);
insert into product_d_img values('m_knit_11_d_1.jpg',126);
insert into product_d_img values('m_knit_12_d_1.jpg',127);
insert into product_d_img values('m_knit_13_d_1.jpg',128);
insert into product_d_img values('m_knit_14_d_1.jpg',129);
insert into product_d_img values('m_knit_15_d_1.jpg',130);
insert into product_d_img values('m_knit_16_d_1.jpg',131);
insert into product_d_img values('m_knit_17_d_1.jpg',132);
insert into product_d_img values('m_knit_18_d_1.jpg',133);
insert into product_d_img values('m_knit_19_d_1.jpg',134);
insert into product_d_img values('m_knit_2_d_1.jpg',117);
insert into product_d_img values('m_knit_20_d_1.jpg',135);
insert into product_d_img values('m_knit_21_d_1.jpg',136);
insert into product_d_img values('m_knit_3_d_1.jpg',118);
insert into product_d_img values('m_knit_4_d_1.jpg',119);
insert into product_d_img values('m_knit_5_d_1.jpg',120);
insert into product_d_img values('m_knit_6_d_1.jpg',121);
insert into product_d_img values('m_knit_7_d_1.jpg',122);
insert into product_d_img values('m_knit_8_d_1.jpg',123);
insert into product_d_img values('m_knit_9_d_1.jpg',124);
insert into product_d_img values('m_outer_1_d_1.jpg',96);
insert into product_d_img values('m_outer_10_d_1.jpg',105);
insert into product_d_img values('m_outer_11_d_1.jpg',106);
insert into product_d_img values('m_outer_12_d_1.jpg',107);
insert into product_d_img values('m_outer_13_d_1.jpg',108);
insert into product_d_img values('m_outer_14_d_1.jpg',109);
insert into product_d_img values('m_outer_15_d_1.jpg',110);
insert into product_d_img values('m_outer_16_d_1.jpg',111);
insert into product_d_img values('m_outer_17_d_1.jpg',112);
insert into product_d_img values('m_outer_18_d_1.jpg',113);
insert into product_d_img values('m_outer_19_d_1.jpg',114);
insert into product_d_img values('m_outer_2_d_1.jpg',97);
insert into product_d_img values('m_outer_20_d_1.jpg',115);
insert into product_d_img values('m_outer_3_d_1.jpg',98);
insert into product_d_img values('m_outer_4_d_1.jpg',99);
insert into product_d_img values('m_outer_5_d_1.jpg',100);
insert into product_d_img values('m_outer_6_d_1.jpg',101);
insert into product_d_img values('m_outer_7_d_1.jpg',102);
insert into product_d_img values('m_outer_8_d_1.jpg',103);
insert into product_d_img values('m_outer_9_d_1.jpg',104);
insert into product_d_img values('m_pants_1_d_1.jpg',63);
insert into product_d_img values('m_pants_10_d_1.jpg',72);
insert into product_d_img values('m_pants_11_d_1.jpg',73);
insert into product_d_img values('m_pants_12_d_1.jpg',74);
insert into product_d_img values('m_pants_13_d_1.jpg',75);
insert into product_d_img values('m_pants_14_d_1.jpg',76);
insert into product_d_img values('m_pants_15_d_1.jpg',77);
insert into product_d_img values('m_pants_16_d_1.jpg',78);
insert into product_d_img values('m_pants_17_d_1.jpg',79);
insert into product_d_img values('m_pants_18_d_1.jpg',80);
insert into product_d_img values('m_pants_19_d_1.jpg',81);
insert into product_d_img values('m_pants_2_d_1.jpg',64);
insert into product_d_img values('m_pants_20_d_1.jpg',82);
insert into product_d_img values('m_pants_21_d_1.jpg',83);
insert into product_d_img values('m_pants_22_d_1.jpg',84);
insert into product_d_img values('m_pants_23_d_1.jpg',85);
insert into product_d_img values('m_pants_24_d_1.jpg',86);
insert into product_d_img values('m_pants_25_d_1.jpg',87);
insert into product_d_img values('m_pants_26_d_1.jpg',88);
insert into product_d_img values('m_pants_27_d_1.jpg',89);
insert into product_d_img values('m_pants_28_d_1.jpg',90);
insert into product_d_img values('m_pants_29_d_1.jpg',91);
insert into product_d_img values('m_pants_3_d_1.jpg',65);
insert into product_d_img values('m_pants_30_d_1.jpg',92);
insert into product_d_img values('m_pants_31_d_1.jpg',93);
insert into product_d_img values('m_pants_32_d_1.jpg',94);
insert into product_d_img values('m_pants_33_d_1.jpg',95);
insert into product_d_img values('m_pants_4_d_1.jpg',66);
insert into product_d_img values('m_pants_5_d_1.jpg',67);
insert into product_d_img values('m_pants_6_d_1.jpg',68);
insert into product_d_img values('m_pants_7_d_1.jpg',69);
insert into product_d_img values('m_pants_8_d_1.jpg',70);
insert into product_d_img values('m_pants_9_d_1.jpg',71);
insert into product_d_img values('m_shirts_1_d_1.jpg',59);
insert into product_d_img values('m_shirts_10_d_1.jpg',44);
insert into product_d_img values('m_shirts_11_d_1.jpg',53);
insert into product_d_img values('m_shirts_12_d_1.jpg',54);
insert into product_d_img values('m_shirts_13_d_1.jpg',55);
insert into product_d_img values('m_shirts_14_d_1.jpg',56);
insert into product_d_img values('m_shirts_15_d_1.jpg',57);
insert into product_d_img values('m_shirts_16_d_1.jpg',58);
insert into product_d_img values('m_shirts_17_d_1.jpg',60);
insert into product_d_img values('m_shirts_18_d_1.jpg',61);
insert into product_d_img values('m_shirts_19_d_1.jpg',62);
insert into product_d_img values('m_shirts_2_d_1.jpg',45);
insert into product_d_img values('m_shirts_3_d_1.jpg',46);
insert into product_d_img values('m_shirts_4_d_1.jpg',48);
insert into product_d_img values('m_shirts_5_d_1.jpg',49);
insert into product_d_img values('m_shirts_6_d_1.jpg',50);
insert into product_d_img values('m_shirts_7_d_1.jpg',51);
insert into product_d_img values('m_shirts_8_d_1.jpg',52);
insert into product_d_img values('m_shirts_9_d_1.jpg',47);
insert into product_d_img values('m_shoes_1_d_1.jpg',24);
insert into product_d_img values('m_shoes_10_d_1.jpg',33);
insert into product_d_img values('m_shoes_11_d_1.jpg',34);
insert into product_d_img values('m_shoes_12_d_1.jpg',35);
insert into product_d_img values('m_shoes_13_d_1.jpg',36);
insert into product_d_img values('m_shoes_14_d_1.jpg',37);
insert into product_d_img values('m_shoes_15_d_1.jpg',38);
insert into product_d_img values('m_shoes_16_d_1.jpg',39);
insert into product_d_img values('m_shoes_17_d_1.jpg',40);
insert into product_d_img values('m_shoes_18_d_1.jpg',41);
insert into product_d_img values('m_shoes_19_d_1.jpg',42);
insert into product_d_img values('m_shoes_2_d_1.jpg',25);
insert into product_d_img values('m_shoes_20_d_1.jpg',43);
insert into product_d_img values('m_shoes_3_d_1.jpg',26);
insert into product_d_img values('m_shoes_4_d_1.jpg',27);
insert into product_d_img values('m_shoes_5_d_1.jpg',28);
insert into product_d_img values('m_shoes_6_d_1.jpg',29);
insert into product_d_img values('m_shoes_7_d_1.jpg',30);
insert into product_d_img values('m_shoes_8_d_1.jpg',31);
insert into product_d_img values('m_shoes_9_d_1.jpg',32);
insert into product_d_img values('m_suit_1_d_1.jpg',159);
insert into product_d_img values('m_suit_10_d_1.jpg',160);
insert into product_d_img values('m_suit_11_d_1.jpg',161);
insert into product_d_img values('m_suit_12_d_1.jpg',162);
insert into product_d_img values('m_suit_2_d_1.jpg',163);
insert into product_d_img values('m_suit_3_d_1.jpg',164);
insert into product_d_img values('m_suit_4_d_1.jpg',165);
insert into product_d_img values('m_suit_5_d_1.jpg',166);
insert into product_d_img values('m_suit_6_d_1.jpg',167);
insert into product_d_img values('m_suit_7_d_1.jpg',168);
insert into product_d_img values('m_suit_8_d_1.jpg',169);
insert into product_d_img values('m_suit_9_d_1.jpg',170);
insert into product_d_img values('m_top_1_d_1.jpg',1);
insert into product_d_img values('m_top_10_d_1.jpg',10);
insert into product_d_img values('m_top_11_d_1.jpg',11);
insert into product_d_img values('m_top_12_d_1.jpg',12);
insert into product_d_img values('m_top_13_d_1.jpg',13);
insert into product_d_img values('m_top_14_d_1.jpg',14);
insert into product_d_img values('m_top_15_d_1.jpg',15);
insert into product_d_img values('m_top_16_d_1.jpg',16);
insert into product_d_img values('m_top_17_d_1.jpg',17);
insert into product_d_img values('m_top_18_d_1.jpg',18);
insert into product_d_img values('m_top_19_d_1.jpg',19);
insert into product_d_img values('m_top_2_d_1.jpg',2);
insert into product_d_img values('m_top_20_d_1.jpg',20);
insert into product_d_img values('m_top_21_d_1.jpg',21);
insert into product_d_img values('m_top_22_d_1.jpg',22);
insert into product_d_img values('m_top_23_d_1.jpg',23);
insert into product_d_img values('m_top_3_d_1.jpg',3);
insert into product_d_img values('m_top_4_d_1.jpg',4);
insert into product_d_img values('m_top_5_d_1.jpg',5);
insert into product_d_img values('m_top_6_d_1.jpg',6);
insert into product_d_img values('m_top_7_d_1.jpg',7);
insert into product_d_img values('m_top_8_d_1.jpg',8);
insert into product_d_img values('m_top_9_d_1.jpg',9);
insert into product_d_img values('w_bottom_1_d_1.jpg',137);
insert into product_d_img values('w_bottom_10_d_1.jpg',138);
insert into product_d_img values('w_bottom_11_d_1.jpg',139);
insert into product_d_img values('w_bottom_2_d_1.jpg',140);
insert into product_d_img values('w_bottom_3_d_1.jpg',141);
insert into product_d_img values('w_bottom_4_d_1.jpg',142);
insert into product_d_img values('w_bottom_5_d_1.jpg',143);
insert into product_d_img values('w_bottom_6_d_1.jpg',144);
insert into product_d_img values('w_bottom_7_d_1.jpg',145);
insert into product_d_img values('w_bottom_8_d_1.jpg',146);
insert into product_d_img values('w_bottom_9_d_1.jpg',147);
insert into product_d_img values('w_knit_1_d_1.gif',148);
insert into product_d_img values('w_knit_2_d_1.gif',149);
insert into product_d_img values('w_knit_3_d_1.jpg',150);
insert into product_d_img values('w_outer_1_d_1.jpg',151);
insert into product_d_img values('w_outer_2_d_1.jpg',152);
insert into product_d_img values('w_outer_3_d_1.jpg',153);
insert into product_d_img values('w_outer_4_d_1.jpg',154);
insert into product_d_img values('w_outer_5_d_1.jpg',155);
insert into product_d_img values('w_shirts_1_d_1.jpg',156);
insert into product_d_img values('w_shirts_2_d_1.jpg',157);
insert into product_d_img values('w_shirts_3_d_1.jpg',158);
insert into product_d_img values('w_top_1_d_1.jpg',171);
insert into product_d_img values('w_top_2_d_1.jpg',172);
insert into product_d_img values('w_top_3_d_1.jpg',173);
insert into product_d_img values('w_top_4_d_1.jpg',174);
insert into product_d_img values('w_top_5_d_1.jpg',175);
insert into product_d_img values('w_top_6_d_1.jpg',176);
insert into product_d_img values('w_top_7_d_1.jpg',177);
insert into product_d_img values('w_top_8_d_1.jpg',178);
insert into product_t_img values('m_knit_1_t_1.jpg',116);
insert into product_t_img values('m_knit_10_t_1.jpg',125);
insert into product_t_img values('m_knit_11_t_1.jpg',126);
insert into product_t_img values('m_knit_12_t_1.jpg',127);
insert into product_t_img values('m_knit_13_t_1.jpg',128);
insert into product_t_img values('m_knit_14_t_1.jpg',129);
insert into product_t_img values('m_knit_15_t_1.jpg',130);
insert into product_t_img values('m_knit_16_t_1.jpg',131);
insert into product_t_img values('m_knit_17_t_1.jpg',132);
insert into product_t_img values('m_knit_18_t_1.jpg',133);
insert into product_t_img values('m_knit_19_t_1.jpg',134);
insert into product_t_img values('m_knit_2_t_1.jpg',117);
insert into product_t_img values('m_knit_20_t_1.jpg',135);
insert into product_t_img values('m_knit_21_t_1.jpg',136);
insert into product_t_img values('m_knit_3_t_1.jpg',118);
insert into product_t_img values('m_knit_4_t_1.jpg',119);
insert into product_t_img values('m_knit_5_t_1.jpg',120);
insert into product_t_img values('m_knit_6_t_1.jpg',121);
insert into product_t_img values('m_knit_7_t_1.jpg',122);
insert into product_t_img values('m_knit_8_t_1.jpg',123);
insert into product_t_img values('m_knit_9_t_1.jpg',124);
insert into product_t_img values('m_outer_1_t_1.jpg',96);
insert into product_t_img values('m_outer_10_t_1.jpg',105);
insert into product_t_img values('m_outer_11_t_1.jpg',106);
insert into product_t_img values('m_outer_12_t_1.jpg',107);
insert into product_t_img values('m_outer_13_t_1.jpg',108);
insert into product_t_img values('m_outer_14_t_1.jpg',109);
insert into product_t_img values('m_outer_15_t_1.jpg',110);
insert into product_t_img values('m_outer_16_t_1.jpg',111);
insert into product_t_img values('m_outer_17_t_1.jpg',112);
insert into product_t_img values('m_outer_18_t_1.jpg',113);
insert into product_t_img values('m_outer_19_t_1.jpg',114);
insert into product_t_img values('m_outer_2_t_1.jpg',97);
insert into product_t_img values('m_outer_20_t_1.jpg',115);
insert into product_t_img values('m_outer_3_t_1.jpg',98);
insert into product_t_img values('m_outer_4_t_1.jpg',99);
insert into product_t_img values('m_outer_5_t_1.jpg',100);
insert into product_t_img values('m_outer_6_t_1.jpg',101);
insert into product_t_img values('m_outer_7_t_1.jpg',102);
insert into product_t_img values('m_outer_8_t_1.jpg',103);
insert into product_t_img values('m_outer_9_t_1.jpg',104);
insert into product_t_img values('m_pants_1_t_1.jpg',63);
insert into product_t_img values('m_pants_10_t_1.jpg',72);
insert into product_t_img values('m_pants_11_t_1.jpg',73);
insert into product_t_img values('m_pants_12_t_1.jpg',74);
insert into product_t_img values('m_pants_13_t_1.jpg',75);
insert into product_t_img values('m_pants_14_t_1.jpg',76);
insert into product_t_img values('m_pants_15_t_1.jpg',77);
insert into product_t_img values('m_pants_16_t_1.jpg',78);
insert into product_t_img values('m_pants_17_t_1.jpg',79);
insert into product_t_img values('m_pants_18_t_1.jpg',80);
insert into product_t_img values('m_pants_19_t_1.jpg',81);
insert into product_t_img values('m_pants_2_t_1.jpg',64);
insert into product_t_img values('m_pants_20_t_1.jpg',82);
insert into product_t_img values('m_pants_21_t_1.jpg',83);
insert into product_t_img values('m_pants_22_t_1.jpg',84);
insert into product_t_img values('m_pants_23_t_1.jpg',85);
insert into product_t_img values('m_pants_24_t_1.jpg',86);
insert into product_t_img values('m_pants_25_t_1.jpg',87);
insert into product_t_img values('m_pants_26_t_1.jpg',88);
insert into product_t_img values('m_pants_27_t_1.jpg',89);
insert into product_t_img values('m_pants_28_t_1.jpg',90);
insert into product_t_img values('m_pants_29_t_1.jpg',91);
insert into product_t_img values('m_pants_3_t_1.jpg',65);
insert into product_t_img values('m_pants_30_t_1.jpg',92);
insert into product_t_img values('m_pants_31_t_1.jpg',93);
insert into product_t_img values('m_pants_32_t_1.jpg',94);
insert into product_t_img values('m_pants_33_t_1.jpg',95);
insert into product_t_img values('m_pants_4_t_1.jpg',66);
insert into product_t_img values('m_pants_5_t_1.jpg',67);
insert into product_t_img values('m_pants_6_t_1.jpg',68);
insert into product_t_img values('m_pants_7_t_1.jpg',69);
insert into product_t_img values('m_pants_8_t_1.jpg',70);
insert into product_t_img values('m_pants_9_t_1.jpg',71);
insert into product_t_img values('m_shirts_1_t_1.jpg',59);
insert into product_t_img values('m_shirts_10_t_1.jpg',44);
insert into product_t_img values('m_shirts_11_t_1.jpg',53);
insert into product_t_img values('m_shirts_12_t_1.jpg',54);
insert into product_t_img values('m_shirts_13_t_1.jpg',55);
insert into product_t_img values('m_shirts_14_t_1.jpg',56);
insert into product_t_img values('m_shirts_15_t_1.jpg',57);
insert into product_t_img values('m_shirts_16_t_1.jpg',58);
insert into product_t_img values('m_shirts_17_t_1.jpg',60);
insert into product_t_img values('m_shirts_18_t_1.jpg',61);
insert into product_t_img values('m_shirts_19_t_1.jpg',62);
insert into product_t_img values('m_shirts_2_t_1.jpg',45);
insert into product_t_img values('m_shirts_3_t_1.jpg',46);
insert into product_t_img values('m_shirts_4_t_1.jpg',48);
insert into product_t_img values('m_shirts_5_t_1.jpg',49);
insert into product_t_img values('m_shirts_6_t_1.jpg',50);
insert into product_t_img values('m_shirts_7_t_1.jpg',51);
insert into product_t_img values('m_shirts_8_t_1.jpg',52);
insert into product_t_img values('m_shirts_9_t_1.jpg',47);
insert into product_t_img values('m_shoes_1_t_1.jpg',24);
insert into product_t_img values('m_shoes_10_t_1.jpg',33);
insert into product_t_img values('m_shoes_11_t_1.jpg',34);
insert into product_t_img values('m_shoes_12_t_1.jpg',35);
insert into product_t_img values('m_shoes_13_t_1.jpg',36);
insert into product_t_img values('m_shoes_14_t_1.jpg',37);
insert into product_t_img values('m_shoes_15_t_1.jpg',38);
insert into product_t_img values('m_shoes_16_t_1.jpg',39);
insert into product_t_img values('m_shoes_17_t_1.jpg',40);
insert into product_t_img values('m_shoes_18_t_1.jpg',41);
insert into product_t_img values('m_shoes_19_t_1.jpg',42);
insert into product_t_img values('m_shoes_2_t_1.jpg',25);
insert into product_t_img values('m_shoes_20_t_1.jpg',43);
insert into product_t_img values('m_shoes_3_t_1.jpg',26);
insert into product_t_img values('m_shoes_4_t_1.jpg',27);
insert into product_t_img values('m_shoes_5_t_1.jpg',28);
insert into product_t_img values('m_shoes_6_t_1.jpg',29);
insert into product_t_img values('m_shoes_7_t_1.jpg',30);
insert into product_t_img values('m_shoes_8_t_1.jpg',31);
insert into product_t_img values('m_shoes_9_t_1.jpg',32);
insert into product_t_img values('m_suit_1_t_1.jpg',159);
insert into product_t_img values('m_suit_10_t_1.jpg',160);
insert into product_t_img values('m_suit_11_t_1.jpg',161);
insert into product_t_img values('m_suit_12_t_1.jpg',162);
insert into product_t_img values('m_suit_2_t_1.jpg',163);
insert into product_t_img values('m_suit_3_t_1.jpg',164);
insert into product_t_img values('m_suit_4_t_1.jpg',165);
insert into product_t_img values('m_suit_5_t_1.jpg',166);
insert into product_t_img values('m_suit_6_t_1.jpg',167);
insert into product_t_img values('m_suit_7_t_1.jpg',168);
insert into product_t_img values('m_suit_8_t_1.jpg',169);
insert into product_t_img values('m_suit_9_t_1.jpg',170);
insert into product_t_img values('m_top_1_t_1.jpg',1);
insert into product_t_img values('m_top_10_t_1.jpg',10);
insert into product_t_img values('m_top_11_t_1.jpg',11);
insert into product_t_img values('m_top_12_t_1.jpg',12);
insert into product_t_img values('m_top_13_t_1.jpg',13);
insert into product_t_img values('m_top_14_t_1.jpg',14);
insert into product_t_img values('m_top_15_t_1.jpg',15);
insert into product_t_img values('m_top_16_t_1.jpg',16);
insert into product_t_img values('m_top_17_t_1.jpg',17);
insert into product_t_img values('m_top_18_t_1.jpg',18);
insert into product_t_img values('m_top_19_t_1.jpg',19);
insert into product_t_img values('m_top_2_t_1.jpg',2);
insert into product_t_img values('m_top_20_t_1.jpg',20);
insert into product_t_img values('m_top_21_t_1.jpg',21);
insert into product_t_img values('m_top_22_t_1.jpg',22);
insert into product_t_img values('m_top_23_t_1.jpg',23);
insert into product_t_img values('m_top_3_t_1.jpg',3);
insert into product_t_img values('m_top_4_t_1.jpg',4);
insert into product_t_img values('m_top_5_t_1.jpg',5);
insert into product_t_img values('m_top_6_t_1.jpg',6);
insert into product_t_img values('m_top_7_t_1.jpg',7);
insert into product_t_img values('m_top_8_t_1.jpg',8);
insert into product_t_img values('m_top_9_t_1.jpg',9);
insert into product_t_img values('w_bottom_1_t_1.jpg',137);
insert into product_t_img values('w_bottom_10_t_1.jpg',138);
insert into product_t_img values('w_bottom_11_t_1.jpg',139);
insert into product_t_img values('w_bottom_2_t_1.jpg',140);
insert into product_t_img values('w_bottom_3_t_1.jpg',141);
insert into product_t_img values('w_bottom_4_t_1.jpg',142);
insert into product_t_img values('w_bottom_5_t_1.jpg',143);
insert into product_t_img values('w_bottom_6_t_1.jpg',144);
insert into product_t_img values('w_bottom_7_t_1.jpg',145);
insert into product_t_img values('w_bottom_8_t_1.jpg',146);
insert into product_t_img values('w_bottom_9_t_1.jpg',147);
insert into product_t_img values('w_knit_1_t_1.jpg',148);
insert into product_t_img values('w_knit_2_t_1.jpg',149);
insert into product_t_img values('w_knit_3_t_1.jpg',150);
insert into product_t_img values('w_outer_1_t_1.jpg',151);
insert into product_t_img values('w_outer_2_t_1.jpg',152);
insert into product_t_img values('w_outer_3_t_1.jpg',153);
insert into product_t_img values('w_outer_4_t_1.jpg',154);
insert into product_t_img values('w_outer_5_t_1.jpg',155);
insert into product_t_img values('w_shirts_1_t_1.jpg',156);
insert into product_t_img values('w_shirts_2_t_1.jpg',157);
insert into product_t_img values('w_shirts_3_t_1.jpg',158);
insert into product_t_img values('w_top_1_t_1.jpg',171);
insert into product_t_img values('w_top_2_t_1.jpg',172);
insert into product_t_img values('w_top_3_t_1.jpg',173);
insert into product_t_img values('w_top_4_t_1.jpg',174);
insert into product_t_img values('w_top_5_t_1.jpg',175);
insert into product_t_img values('w_top_6_t_1.jpg',176);
insert into product_t_img values('w_top_7_t_1.jpg',177);
insert into product_t_img values('w_top_8_t_1.jpg',178);
------------------------------------------------------------------------

-- product_opt 可记 歹固

insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'XL','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'M','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'M','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'M','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'L','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'L','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'L','酒捞焊府',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'XL','喉发',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'XL','家扼',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'XL','酒捞焊府',100);




