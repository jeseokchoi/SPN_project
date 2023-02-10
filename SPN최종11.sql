--table 삭제
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

-- product/qna 삭제 --
drop sequence product_review_seq;
drop sequence review_reply_seq;
drop sequence product_seq;
drop sequence cart_seq;
drop sequence product_opt_seq;

drop sequence qna_seq;
drop sequence qna_reply_seq;
drop sequence notice_seq;

-- user/nonuser 삭제 --
drop sequence nonuserOrder_detail_seq;
drop sequence nonuserOrder_refund_seq;
drop sequence nonuserOrder_exchange_seq;
drop sequence nonuser_order_seq;

drop sequence userOrder_detail_seq;
drop sequence userOrder_refund_seq;
drop sequence user_idx_seq;
drop sequence user_order_seq;
drop sequence userOrder_exchange_idx;

-- product/qna 생성 --
create sequence product_review_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence review_reply_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence product_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence product_opt_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence cart_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;

create sequence qna_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence qna_reply_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence notice_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
------------------------------------------------------------------------

-- user/nonuser 생성 --
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

-- user테이블 생성 --

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
    user_gender varchar2(20)        check(user_gender in('여성','남성')) NOT NULL
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

-- userOrder table 생성
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
	order_detail_status	varchar(20) default '주문확인중',
    
    constraint user_order_user
    foreign key(user_id)
    references userTable(user_id)
);
-- deliverAddress table 생성

CREATE TABLE deliver_address (
	user_id	varchar2(30)	NOT NULL,
	user_address1	varchar2(20)	NOT NULL,
	user_address2	varchar2(50)	NOT NULL,
	user_address3	varchar2(50)	NOT NULL,
    
    constraint deliver_address_userTable
    FOREIGN key(user_id)
    REFERENCES userTable(user_id)
);
--product table 생성
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

--썸네일 테이블 생성
create table product_t_img (
    product_t_img           varchar2(100)            not null,
    product_idx             number                   not null,   
    
    constraint product_t_img_product
    foreign key(product_idx)
    references product(product_idx)
);

--상세이미지 테이블 생성
create table product_d_img (
    product_d_img           varchar2(100)            not null,
    product_idx             number                   not null,   
    
    constraint product_d_img_product
    foreign key(product_idx)
    references product(product_idx)
);

--제품 옵션 테이블 생성
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

--장바구니 테이블 생성
create table cart (
    cart_idx                number            default cart_seq.nextval  primary key,
    product_opt_idx         number            not null,
    cart_value              varchar2(30)      not null,
    product_count           number            default 0 not null, --제품수량인데 0이면 안되나?
    
    constraint cart_product_opt
    foreign key(product_opt_idx)
    references product_opt(product_opt_idx)
);

--제품리뷰 테이블 생성
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

--리뷰에 답글 테이블 생성
create table review_reply (
    review_reply_idx           number           default product_review_seq.nextval  primary key,
    product_review_idx         number           not null,
    content                    varchar2(30)     not null,
    writing_date               date             default sysdate not null,
    
    constraint review_reply_product_review
    foreign key(product_review_idx)
    references product_review(product_review_idx)
);
--userOrder_detail 테이블 생성
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

--userOrder Refund 테이블 생성

CREATE TABLE userOrder_refund (
	userOrder_refund_idx	number	DEFAULT userOrder_refund_seq.nextval primary key,
	userOrder_detail_idx	number	NOT NULL,
	refund_reason	varchar2(3000)	NOT NULL,
	reason_img	varchar2(300)	NOT NULL,
	userOrder_refund_status	varchar(50)	default '접수완료',
    
    constraint userOrder_refund_userOrder_detail
    FOREIGN key(userOrder_detail_idx)
    REFERENCES userOrder_detail(userOrder_detail_idx)
  
);

CREATE TABLE userOrder_exchange (
	userOrder_exchange_idx	number	DEFAULT userOrder_exchange_idx.nextval,
	userOrder_detail_idx	number	NOT NULL,
	exchange_reason	varchar2(3000)	NOT NULL,
	reason_img	varchar2(300)	NOT NULL,
	userOrder_exchange_status	varchar(50) default '접수완료',
    
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
	nonuser_order_status	varchar2(50)		default '주문확인중' ,  
    nonuser_pwd             varchar2(20)        NOT NULL
);
--nonuserOrder detail
CREATE TABLE nonuserOrder_detail (
	nonuserOrder_detail_idx	number	DEFAULT nonuserOrder_detail_seq.nextval primary key,
	product_opt_idx         	number	NOT NULL,
	nonuser_order_idx	    number  NOT NULL,
	
    product_count	number		NOT NULL,
	product_price	number		NOT NULL,
    
    constraint fk_nonuser_order  --  제약조건의 이름
    foreign key(nonuser_order_idx)           --  외래키가될 컬럼
    REFERENCES nonuser_order(nonuser_order_idx),    --  외래키가 참조하는 테이블 (컬럼)
           
    constraint fk_product_opt  --  제약조건의 이름
    foreign key(product_opt_idx)           --  외래키가될 컬럼
    REFERENCES product_opt(product_opt_idx)    --  외래키가 참조하는 테이블 (컬럼)
       --  부모키가 삭제될 경우 처리  // 상품이 제거되면 매출건도 사라진다.
);
--nonuserOrder_refund
CREATE TABLE nonuserOrder_refund (
	nonuserOrder_refund_idx	number	DEFAULT nonuserOrder_refund_seq.nextval primary key,
	nonuserOrder_detail_idx	number NOT NULL,
	refund_reason	varchar2(3000)		NOT NULL,
	reason_img	varchar2(300)		NOT NULL,
	nonuserOrder_refund_status	varchar2(50)		default '접수완료',  -- 이미지에 email로 되어있어서 그렇게 만들었었음.

    constraint fk_nonuserOrder_detail  --  제약조건의 이름
    foreign key(nonuserOrder_detail_idx)           --  외래키가될 컬럼
    REFERENCES nonuserOrder_detail(nonuserOrder_detail_idx)    --  외래키가 참조하는 테이블 (컬럼)
);
--nonuserOrder_exchange
CREATE TABLE nonuserOrder_exchange (
	nonuserOrder_exchange_idx	number	DEFAULT nonuserOrder_exchange_seq.nextval primary key,
	nonuserOrder_detail_idx	number NOT NULL,
	exchange_reason	varchar2(3000)		NOT NULL,
	reason_img	varchar2(300)		NOT NULL,
	nonuserOrder_exchange_status	varchar2(50)		default '접수완료',-- 변경해주는 
    
    constraint fk_nonuserOrder_detail2  --  제약조건의 이름
    foreign key(nonuserOrder_detail_idx)           --  외래키가될 컬럼
    REFERENCES nonuserOrder_detail(nonuserOrder_detail_idx)    --  외래키가 참조하는 테이블 (컬럼)

);

insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('UnwtWO37','test1234!@','홍문철','1982-01-13','남성','010-3406-5339','UnwtWO37@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('fZrLdG95','test1234!@','신성숙','2000-10-23','남성','010-4961-6980','fZrLdG95@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('fwxLHU60','test1234!@','허은경','1995-02-02','남성','010-7370-4980','fwxLHU60@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('CLeLwR82','test1234!@','강우태','1994-03-15','남성','010-7613-2290','CLeLwR82@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('rlReFg93','test1234!@','전명욱','1996-01-22','남성','010-6748-4697','rlReFg93@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('wzBsVc87','test1234!@','사공승기','1996-02-15','남성','010-2986-4989','wzBsVc87@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('uWgSgq70','test1234!@','백광호','1995-01-04','남성','010-6455-6164','uWgSgq70@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('pYHZAb59','test1234!@','노용철','1999-12-02','남성','010-2668-7560','pYHZAb59@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('dYzsUd66','test1234!@','박승근','1981-08-07','남성','010-4780-8207','dYzsUd66@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('zPVaYB33','test1234!@','황정혁','1997-01-04','남성','010-7809-4157','zPVaYB33@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('YGshpn97','test1234!@','백명선','1990-11-28','남성','010-4554-7828','YGshpn97@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('dUteJB40','test1234!@','안동빈','1987-07-06','남성','010-4124-7184','dUteJB40@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('KgcCXs43','test1234!@','류효민','2002-09-13','남성','010-8742-7149','KgcCXs43@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('EOHmJC56','test1234!@','남병하','1995-11-01','남성','010-8857-2235','EOHmJC56@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('DMKnnD87','test1234!@','성유진','1992-10-22','남성','010-3188-6252','DMKnnD87@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('nZeBmC16','test1234!@','안해일','1984-10-26','남성','010-7297-2181','nZeBmC16@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('gpLvvj41','test1234!@','노현경','1997-07-27','남성','010-3823-4594','gpLvvj41@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('rHtSTI72','test1234!@','류준용','1988-11-16','남성','010-7755-7016','rHtSTI72@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('cvsxVu92','test1234!@','남윤준','1988-02-05','남성','010-2900-2104','cvsxVu92@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('zDiPIW83','test1234!@','백성호','1999-02-01','남성','010-3525-1417','zDiPIW83@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('wwTnsG55','test1234!@','류홍기','1991-10-07','남성','010-8205-7510','wwTnsG55@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('ScePkt52','test1234!@','봉유진','1980-10-13','남성','010-7939-7426','ScePkt52@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('WKwBhF62','test1234!@','한은하','1995-07-27','남성','010-4782-8225','WKwBhF62@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('OWrOwJ79','test1234!@','사공윤정','1984-08-05','남성','010-5717-2165','OWrOwJ79@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('IHgEAW25','test1234!@','이태석','1991-11-01','남성','010-3082-7436','IHgEAW25@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('XcSZni35','test1234!@','문세진','1995-06-12','남성','010-7609-1522','XcSZni35@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('NcSBdD29','test1234!@','김석주','1990-12-10','남성','010-9564-2632','NcSBdD29@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('SrsSEL34','test1234!@','배은우','2003-06-05','남성','010-5998-8609','SrsSEL34@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('glhJAQ84','test1234!@','제갈명숙','1999-03-29','남성','010-4668-3799','glhJAQ84@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('sjKXlm25','test1234!@','류현태','1987-01-28','남성','010-5932-3426','sjKXlm25@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('WsjgUg67','test1234!@','황재섭','1981-06-11','여성','010-5540-9783','WsjgUg67@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('dwPlKf63','test1234!@','배철순','2000-01-02','여성','010-8854-9691','dwPlKf63@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('IUBYjr86','test1234!@','황보경구','1997-12-12','여성','010-4712-4447','IUBYjr86@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('xoFTmj2','test1234!@','정철순','1980-10-03','여성','010-2238-8198','xoFTmj2@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('gBOxjO33','test1234!@','추무열','1990-02-15','여성','010-5257-7485','gBOxjO33@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('oNaynr78','test1234!@','풍현승','1988-08-20','남성','010-1050-7727','oNaynr78@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('EzMXPG3','test1234!@','정재범','1992-11-06','남성','010-2058-1385','EzMXPG3@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('kLUpoq33','test1234!@','하광조','2003-03-09','남성','010-9459-9410','kLUpoq33@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('pZEoCz88','test1234!@','황철순','1994-12-18','남성','010-8736-9845','pZEoCz88@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('DrOGnG62','test1234!@','노덕수','1992-08-16','남성','010-8841-2706','DrOGnG62@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('VTOjAT49','test1234!@','이현승','1980-06-07','여성','010-3157-2462','VTOjAT49@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('XJyCZZ61','test1234!@','서동건','1992-05-07','여성','010-6514-2237','XJyCZZ61@naver.com','N','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('fcrovy98','test1234!@','문재범','1984-01-20','여성','010-7699-4335','fcrovy98@naver.com','N','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('EItSUp52','test1234!@','정강민','1992-12-17','여성','010-8484-6762','EItSUp52@naver.com','N','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('eDpBpw6','test1234!@','탁무열','1980-09-06','여성','010-9802-4978','eDpBpw6@naver.com','N','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('wYhyME2','test1234!@','황재섭','1980-03-05','남성','010-2615-7301','wYhyME2@naver.com','N','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('JKHESW34','test1234!@','정경택','1998-10-12','남성','010-5931-8894','JKHESW34@naver.com','N','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('ovRTAz44','test1234!@','장경택','1986-02-05','남성','010-1239-2884','ovRTAz44@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('CsoHlu97','test1234!@','전강민','1985-06-10','남성','010-7768-6226','CsoHlu97@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('vZCDbi97','test1234!@','안치원','1985-03-14','남성','010-6681-3192','vZCDbi97@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('VTEKpP32','test1234!@','남궁경구','1994-04-28','남성','010-3702-6600','VTEKpP32@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('trOGTA24','test1234!@','전동건','1988-12-27','남성','010-3486-8016','trOGTA24@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('nKpupq15','test1234!@','정동건','1997-10-07','남성','010-3028-4986','nKpupq15@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('hESTaB30','test1234!@','추재섭','1994-04-18','남성','010-4660-7437','hESTaB30@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('baNJKX15','test1234!@','양일성','1990-02-09','남성','010-9714-6232','baNJKX15@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('kEAtoR65','test1234!@','고승헌','1993-11-24','남성','010-9618-1601','kEAtoR65@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('wvDnWb84','test1234!@','강무영','2002-10-05','남성','010-6039-6605','wvDnWb84@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('WJueMS21','test1234!@','남궁치원','1982-07-09','남성','010-1676-2820','WJueMS21@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('ogFdTo20','test1234!@','노치원','1988-02-25','남성','010-6673-8114','ogFdTo20@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('AzPciG70','test1234!@','설치원','1981-04-20','남성','010-9465-5905','AzPciG70@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('WzUdCc60','test1234!@','강소라','1999-11-02','남성','010-3267-3406','WzUdCc60@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('mjRDRm11','test1234!@','성잔디','1984-10-19','남성','010-7049-4904','mjRDRm11@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('lAujbT96','test1234!@','이누리','1983-07-25','남성','010-3273-8734','lAujbT96@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('kztVZt81','test1234!@','남나라빛','1999-02-27','남성','010-9100-6374','kztVZt81@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('xrdGjI5','test1234!@','봉보람','1991-04-09','남성','010-5409-6290','xrdGjI5@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('mheOMS15','test1234!@','표아롱','2002-11-14','남성','010-6144-8937','mheOMS15@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('HMWkJe42','test1234!@','장이슬','1990-08-11','남성','010-6694-1143','HMWkJe42@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('SVtlop17','test1234!@','최소리','1981-03-08','남성','010-3639-9093','SVtlop17@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('dnRFMX55','test1234!@','황하루','1994-07-09','여성','010-8004-9226','dnRFMX55@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('ArzZSm10','test1234!@','윤자람','1993-04-10','여성','010-9396-9807','ArzZSm10@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('MZvhZi26','test1234!@','추나비','1984-02-13','여성','010-7436-1360','MZvhZi26@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('zPGuUK34','test1234!@','유나리','1986-09-12','여성','010-3822-1037','zPGuUK34@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('qVNwgH95','test1234!@','설아름','1994-07-24','여성','010-4563-1151','qVNwgH95@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('oYAqbb1','test1234!@','서민들레','2003-01-20','여성','010-4149-8492','oYAqbb1@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('jdAuXP97','test1234!@','신가람','1985-05-26','여성','010-5869-3910','jdAuXP97@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('XaCPzj99','test1234!@','배보람','1995-11-06','여성','010-3160-4273','XaCPzj99@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('HeNkgE81','test1234!@','이한샘','1997-06-14','여성','010-9240-5753','HeNkgE81@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('tVXDXC30','test1234!@','장아라','1981-05-28','여성','010-8671-6440','tVXDXC30@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('LStNSZ90','test1234!@','백솔','1995-11-25','여성','010-9553-7800','LStNSZ90@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('ernGLF68','test1234!@','봉햇빛','1980-05-11','여성','010-7139-8494','ernGLF68@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('kdqLJe48','test1234!@','손기쁨','1990-04-28','여성','010-3777-7355','kdqLJe48@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('pkOCwk5','test1234!@','송두리','1986-04-30','여성','010-1605-4019','pkOCwk5@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('yoztKG24','test1234!@','문마음','1999-03-01','여성','010-7310-5059','yoztKG24@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('HUTEIN97','test1234!@','윤은샘','1997-05-22','여성','010-2742-3865','HUTEIN97@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('hIbeRR98','test1234!@','송구슬','1990-03-07','여성','010-2273-5457','hIbeRR98@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('qolOaA24','test1234!@','류두리','2001-06-15','여성','010-4129-7501','qolOaA24@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('jqfSLv55','test1234!@','정가람','1993-12-07','여성','010-9370-3448','jqfSLv55@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('xifHmX30','test1234!@','추초롱','1994-05-01','여성','010-8988-6212','xifHmX30@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('iuXvxb50','test1234!@','제갈하늘','1981-04-24','여성','010-5569-7525','iuXvxb50@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('JpyLGs26','test1234!@','전샘나','1995-01-30','여성','010-7722-3077','JpyLGs26@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('onOzMc39','test1234!@','조다운','1989-09-24','여성','010-3288-1088','onOzMc39@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('zoraHk37','test1234!@','오힘찬','1996-01-08','여성','010-1835-1894','zoraHk37@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('FvLCIa13','test1234!@','봉샘','1999-01-04','여성','010-8519-4797','FvLCIa13@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('YBKnXk66','test1234!@','서한길','1998-06-11','여성','010-4580-6266','YBKnXk66@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('prCLTb96','test1234!@','노미르','1986-03-26','여성','010-8895-5334','prCLTb96@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('MtUdiA8','test1234!@','남궁나길','1989-02-07','여성','010-1463-2478','MtUdiA8@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('FvDhzH99','test1234!@','윤미르','1994-10-27','여성','010-3061-4499','FvDhzH99@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('FwGLoS28','test1234!@','봉힘찬','1997-04-09','여성','010-3923-9786','FwGLoS28@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('bOuIGy97','test1234!@','설다운','1980-06-22','여성','010-9356-2723','bOuIGy97@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('ixAXRA11','test1234!@','하믿음','1998-01-06','여성','010-5088-4523','ixAXRA11@naver.com','Y','user','bronze');

insert into product(product_code,product_name,product_price) values('m_top_1','올데이 베이직 티셔츠 -반팔 오버핏',24900);
insert into product(product_code,product_name,product_price) values('m_top_2','베이직 레이어드 반팔 티셔츠',12900);
insert into product(product_code,product_name,product_price) values('m_top_3','페브릭 트레이닝 후드',49900);
insert into product(product_code,product_name,product_price) values('m_top_4','캐쥬얼 레터링 맨투맨',32900);
insert into product(product_code,product_name,product_price) values('m_top_5','모나미 베이직 맨투맨',19900);
insert into product(product_code,product_name,product_price) values('m_top_6','뮤즈 베이직 쭈리 맨투맨',27900);
insert into product(product_code,product_name,product_price) values('m_top_7','올데이 베이직 티셔츠 -긴팔 오버핏',24900);
insert into product(product_code,product_name,product_price) values('m_top_8','라운드 넥 실켓 티셔츠',19900);
insert into product(product_code,product_name,product_price) values('m_top_9','데일리 무지 롱슬리브',17900);
insert into product(product_code,product_name,product_price) values('m_top_10','유넥 네츄럴 롱 슬리브 티셔츠',19900);
insert into product(product_code,product_name,product_price) values('m_top_11','소프트 라운드 긴팔티',19900);
insert into product(product_code,product_name,product_price) values('m_top_12','플래닛 발포 맨투맨',44900);
insert into product(product_code,product_name,product_price) values('m_top_13','리버풀 링클프리 라운드 긴팔티',12900);
insert into product(product_code,product_name,product_price) values('m_top_14','스탠다드 롱 슬리브',16900);
insert into product(product_code,product_name,product_price) values('m_top_15','베이직 무지 폴라 티셔츠',27900);
insert into product(product_code,product_name,product_price) values('m_top_16','리버스 오버 맨투맨',34900);
insert into product(product_code,product_name,product_price) values('m_top_17','베이직 트위스트 오버긴팔티',34900);
insert into product(product_code,product_name,product_price) values('m_top_18','8color 데일리 반폴라 니트티',32900);
insert into product(product_code,product_name,product_price) values('m_top_19','데일리 감탄 티셔츠',15900);
insert into product(product_code,product_name,product_price) values('m_top_20','기모 롱 슬리브 - 2차 리오더',21900);
insert into product(product_code,product_name,product_price) values('m_top_21','베이직 라운드 긴팔 티셔츠 [아스킨원단]',29900);
insert into product(product_code,product_name,product_price) values('m_top_22','베이직 폰테 긴팔티',24900);
insert into product(product_code,product_name,product_price) values('m_top_23','4color 하프넥 니트티',29900);
insert into product(product_code,product_name,product_price) values('m_shoes_1','2color 리얼 레더 블로퍼(소가죽)',56800);
insert into product(product_code,product_name,product_price) values('m_shoes_2','2color 언밸런스 슬리퍼',82800);
insert into product(product_code,product_name,product_price) values('m_shoes_3','3color 코튼스트랩 플립플랍',42800);
insert into product(product_code,product_name,product_price) values('m_shoes_4','아일랫 더비 클리퍼',52800);
insert into product(product_code,product_name,product_price) values('m_shoes_5','뉴트럴 스니커즈',49800);
insert into product(product_code,product_name,product_price) values('m_shoes_6','포인트 스퀘어토 레더 더비 슈즈',64800);
insert into product(product_code,product_name,product_price) values('m_shoes_7','리얼레더 텍스쳐 스니커즈',101800);
insert into product(product_code,product_name,product_price) values('m_shoes_8','오딘 레더 페니로퍼',58000);
insert into product(product_code,product_name,product_price) values('m_shoes_9','스티치 슬릿 블랙 로퍼',117000);
insert into product(product_code,product_name,product_price) values('m_shoes_10','샌더 첼시부츠',56000);
insert into product(product_code,product_name,product_price) values('m_shoes_11','런어 메쉬 스니커즈',131000);
insert into product(product_code,product_name,product_price) values('m_shoes_12','미니멀 독일군 스니커즈',54000);
insert into product(product_code,product_name,product_price) values('m_shoes_13','로이드 지퍼 캔버스',44000);
insert into product(product_code,product_name,product_price) values('m_shoes_14','브렌즈 첼시부츠',59900);
insert into product(product_code,product_name,product_price) values('m_shoes_15','레더 더비 클리퍼',149000);
insert into product(product_code,product_name,product_price) values('m_shoes_16','페리 스퀘어토 로퍼',64000);
insert into product(product_code,product_name,product_price) values('m_shoes_17','SS 스티치 더비 슈즈',59900);
insert into product(product_code,product_name,product_price) values('m_shoes_18','베이직 페니로퍼 - 3차 리오더',57900);
insert into product(product_code,product_name,product_price) values('m_shoes_19','스티치 더비 로퍼',59900);
insert into product(product_code,product_name,product_price) values('m_shoes_20','CP 베이직 로우 스니커즈(화이트) - 5차 리오더',39900);
insert into product(product_code,product_name,product_price) values('m_shirts_1','플레인 코튼 셔츠',39900);
insert into product(product_code,product_name,product_price) values('m_shirts_2','미니멀 오버 카라 셔츠',42900);
insert into product(product_code,product_name,product_price) values('m_shirts_3','모던 크롭 셔츠',44900);
insert into product(product_code,product_name,product_price) values('m_shitrs_4','데일리 타탄 체크 셔츠',24900);
insert into product(product_code,product_name,product_price) values('m_shirts_5','Basic 코튼 셔츠',45900);
insert into product(product_code,product_name,product_price) values('m_shirts_6','레이 슬럽데님 셔츠',44900);
insert into product(product_code,product_name,product_price) values('m_shirts_7','루이스 미니멀 셔츠',34900);
insert into product(product_code,product_name,product_price) values('m_shirts_8','세이즈 포플린 셔츠',29900);
insert into product(product_code,product_name,product_price) values('m_shirts_9','심플 히든 셔츠',27900);
insert into product(product_code,product_name,product_price) values('m_shirts_10','6color 스탠다드 셔츠',32900);
insert into product(product_code,product_name,product_price) values('m_shirts_11','9color 링클프리 오버 셔츠',24900);
insert into product(product_code,product_name,product_price) values('m_shirts_12','7color 링클프리 심플 셔츠',22900);
insert into product(product_code,product_name,product_price) values('m_shirts_13','심플 링클프리 셔츠',24900);
insert into product(product_code,product_name,product_price) values('m_shirts_14','베이직 옥스포드 셔츠(긴팔타입)',21900);
insert into product(product_code,product_name,product_price) values('m_shirts_15','베이직 스타일러 셔츠',24900);
insert into product(product_code,product_name,product_price) values('m_shirrs_16','9color 링클프리 히든 셔츠',24900);
insert into product(product_code,product_name,product_price) values('m_shirts_17','매니 솔리드 오버셔츠',27900);
insert into product(product_code,product_name,product_price) values('m_shirts_18','릴렉스 링클프리 셔츠(긴팔타입)',24900);
insert into product(product_code,product_name,product_price) values('m_shirts_19','베이직 링클프리 심플 셔츠',24900);
insert into product(product_code,product_name,product_price) values('m_pants_1','5color 코튼 밴딩 팬츠',39900);
insert into product(product_code,product_name,product_price) values('m_pants_2','하우스 텐션 슬랙스 (구김방지/히든밴딩)',39900);
insert into product(product_code,product_name,product_price) values('m_pants_3','페브릭 트레이닝 팬츠',44900);
insert into product(product_code,product_name,product_price) values('m_pants_4','핀턱 울 와이드 슬랙스',44900);
insert into product(product_code,product_name,product_price) values('m_pants_5','원턱 레귤러 기모 슬랙스',44900);
insert into product(product_code,product_name,product_price) values('m_pants_6','AW 세미 스판 밴딩 슬랙스',34900);
insert into product(product_code,product_name,product_price) values('m_pants_7','로렌 테이퍼드 코튼팬츠',39900);
insert into product(product_code,product_name,product_price) values('m_pants_8','데일리 모던 울 슬랙스',39900);
insert into product(product_code,product_name,product_price) values('m_pants_9','모던 와이드 슬랙스',47900);
insert into product(product_code,product_name,product_price) values('m_pants_10','데일리 스탠다드 데님',49900);
insert into product(product_code,product_name,product_price) values('m_pants_11','3color 크림 네츄럴 데님',49900);
insert into product(product_code,product_name,product_price) values('m_pants_12','유니 코튼 치노 팬츠',32900);
insert into product(product_code,product_name,product_price) values('m_pants_13','모나크 슬랙스',47900);
insert into product(product_code,product_name,product_price) values('m_pants_14','로트 투턱 와이드 슬랙스',29900);
insert into product(product_code,product_name,product_price) values('m_pants_15','오르 스판 슬랙스',34900);
insert into product(product_code,product_name,product_price) values('m_pants_16','유즈 세미와이드 슬랙스',37900);
insert into product(product_code,product_name,product_price) values('m_pants_17','로밍 원턱 스웻팬츠',44900);
insert into product(product_code,product_name,product_price) values('m_pants_18','프로그 와이드 슬랙스',49900);
insert into product(product_code,product_name,product_price) values('m_pants_19','스티즈 와이드 슬랙스',34900);
insert into product(product_code,product_name,product_price) values('m_pants_20','2color 클래식 체크 슬랙스',45900);
insert into product(product_code,product_name,product_price) values('m_pants_21','로먼 트임 데님팬츠 - BLACK',52900);
insert into product(product_code,product_name,product_price) values('m_pants_22','루시 매직 밴딩 슬랙스',34900);
insert into product(product_code,product_name,product_price) values('m_pants_23','밀리 와이드 데님팬츠',34900);
insert into product(product_code,product_name,product_price) values('m_pants_24','르엔느 와이드 직기 슬랙스',39900);
insert into product(product_code,product_name,product_price) values('m_pants_25','하프 오버 핀턱 팬츠',49900);
insert into product(product_code,product_name,product_price) values('m_pants_26','멜튼 코듀로이 밴딩팬츠',24900);
insert into product(product_code,product_name,product_price) values('m_pants_27','시크릿 밴딩 슬랙스',34900);
insert into product(product_code,product_name,product_price) values('m_pants_28','리드 옆트임 와이드 슬랙스',29900);
insert into product(product_code,product_name,product_price) values('m_pants_29','데미지 스트레이트 제로 데님 by showpin (커팅타입)',49900);
insert into product(product_code,product_name,product_price) values('m_pants_30','노르딕 코튼 팬츠',37900);
insert into product(product_code,product_name,product_price) values('m_pants_31','웨스턴 밴딩 코튼팬츠',34900);
insert into product(product_code,product_name,product_price) values('m_pants_32','솔리드 세미와이드 슬랙스',32900);
insert into product(product_code,product_name,product_price) values('m_pants_33','모스트 베이직 슬랙스',29900);
insert into product(product_code,product_name,product_price) values('m_outer_1','필슨 오버 블레이저',94900);
insert into product(product_code,product_name,product_price) values('m_outer_2','마일드 후드 점퍼',39900);
insert into product(product_code,product_name,product_price) values('m_outer_3','오스카 피쉬테일 야상패딩',99000);
insert into product(product_code,product_name,product_price) values('m_outer_4','베이직 심플 항공 점퍼',44900);
insert into product(product_code,product_name,product_price) values('m_outer_5','켈튼 니트 카라 자켓',59900);
insert into product(product_code,product_name,product_price) values('m_outer_6','로디 오버핏 가디건 (~3XL)',29900);
insert into product(product_code,product_name,product_price) values('m_outer_7','에르 울 더블 코트',89900);
insert into product(product_code,product_name,product_price) values('m_outer_8','에르 울 싱글 코트',89900);
insert into product(product_code,product_name,product_price) values('m_outer_9','릴렉스드 울 캐시 자켓',89900);
insert into product(product_code,product_name,product_price) values('m_outer_10','솔리드 울 캐시미어 오버 싱글 코트',109000);
insert into product(product_code,product_name,product_price) values('m_outer_11','8color 클래식 세미오버 자켓',79900);
insert into product(product_code,product_name,product_price) values('m_outer_12','투포켓 핫찌 라운드 집업',59900);
insert into product(product_code,product_name,product_price) values('m_outer_13','AW 솔리드 싱글 자켓',79000);
insert into product(product_code,product_name,product_price) values('m_outer_14','프렌 니트 하프집업',39900);
insert into product(product_code,product_name,product_price) values('m_outer_15','유니 벌룬 자켓',57900);
insert into product(product_code,product_name,product_price) values('m_outer_16','프렌 니트 풀집업',39900);
insert into product(product_code,product_name,product_price) values('m_outer_17','14color 베이직 캐주얼 가디건',39900);
insert into product(product_code,product_name,product_price) values('m_outer_18','AW 울 캐시미어 싱글/더블 코트',99000);
insert into product(product_code,product_name,product_price) values('m_outer_19','데일리 오버 트렌치 코트',72900);
insert into product(product_code,product_name,product_price) values('m_outer_20','브로인 3버튼 싱글 코트',69900);
insert into product(product_code,product_name,product_price) values('m_knit_1','소프트 버튼넥 캐시 니트',39900);
insert into product(product_code,product_name,product_price) values('m_knit_2','레나 심플 usa 니트',39900);
insert into product(product_code,product_name,product_price) values('m_knit_3','2 Type 터틀넥 라운드 니트 - 2차 리오더',24900);
insert into product(product_code,product_name,product_price) values('m_knit_4','오슬로 버튼 터틀넥 니트',39900);
insert into product(product_code,product_name,product_price) values('m_knit_5','멀티 케이블 브이넥 니트',39900);
insert into product(product_code,product_name,product_price) values('m_knit_6','캐시 베이직 라운드니트',44900);
insert into product(product_code,product_name,product_price) values('m_knit_7','베르니 하프집업 니트',44900);
insert into product(product_code,product_name,product_price) values('m_knit_8','모어 라운드넥 니트',44900);
insert into product(product_code,product_name,product_price) values('m_knit_9','클로이 루즈 트임 니트',29900);
insert into product(product_code,product_name,product_price) values('m_knit_10','심플리 라운드 니트',34900);
insert into product(product_code,product_name,product_price) values('m_knit_11','캐시 케이블 라운드 니트',44900);
insert into product(product_code,product_name,product_price) values('m_knit_12','비엔느 V넥 니트',34900);
insert into product(product_code,product_name,product_price) values('m_knit_13','알렌 오픈넥 니트',34900);
insert into product(product_code,product_name,product_price) values('m_knit_14','웨이 골지 캐시 폴라니트',44900);
insert into product(product_code,product_name,product_price) values('m_knit_15','솔리드 와플 니트 - 2차 리오더',24900);
insert into product(product_code,product_name,product_price) values('m_knit_16','소프트 모헤어 카라니트',57900);
insert into product(product_code,product_name,product_price) values('m_knit_17','소프트 하프폴라 니트티',19900);
insert into product(product_code,product_name,product_price) values('m_knit_18','레이 스탠다드 라운드 니트',29900);
insert into product(product_code,product_name,product_price) values('m_knit_19','스탠다드 안티필링 니트티 (보풀방지)',32900);
insert into product(product_code,product_name,product_price) values('m_knit_20','레이 스탠다드 하프넥 니트',29900);
insert into product(product_code,product_name,product_price) values('m_knit_21','와플 심플리 니트',27900);
insert into product(product_code,product_name,product_price) values('w_bottom_1','러넬 와이드 린넨 슬랙스',29900);
insert into product(product_code,product_name,product_price) values('w_bottom_10','2 Type 벨키 하이웨스트 슬랙스 (~4XL)',29900);
insert into product(product_code,product_name,product_price) values('w_bottom_11','레프너 스트레이트핏 데님 (히든밴딩)',27900);
insert into product(product_code,product_name,product_price) values('w_bottom_2','레미 A라인 스커트',19900);
insert into product(product_code,product_name,product_price) values('w_bottom_3','리엔 세미와이드 코튼팬츠',21900);
insert into product(product_code,product_name,product_price) values('w_bottom_4','베럴 스판 크롭 부츠컷',32000);
insert into product(product_code,product_name,product_price) values('w_bottom_5','라이프 크롭 슬림 팬츠',29900);
insert into product(product_code,product_name,product_price) values('w_bottom_6','페넷 투버튼 하이웨스트 부츠컷',27900);
insert into product(product_code,product_name,product_price) values('w_bottom_7','레프너 슬림핏 데님 (히든밴딩)',27900);
insert into product(product_code,product_name,product_price) values('w_bottom_8','제노브 원턱 와이드 슬랙스',27900);
insert into product(product_code,product_name,product_price) values('w_bottom_9','뮤타 뒷밴딩 와이드 슬랙스',29900);
insert into product(product_code,product_name,product_price) values('w_knit_1','멜로우 라운드 반팔 니트',19000);
insert into product(product_code,product_name,product_price) values('w_knit_2','멜로우 브이넥 반팔 니트',19900);
insert into product(product_code,product_name,product_price) values('w_knit_3','로비아 골지 가디건',24900);
insert into product(product_code,product_name,product_price) values('w_outer_1','베네 카라 배색 가디건',34900);
insert into product(product_code,product_name,product_price) values('w_outer_2','이브 카라 니트집업',37900);
insert into product(product_code,product_name,product_price) values('w_outer_3','레티 스트라이프 라운드 가디건',39900);
insert into product(product_code,product_name,product_price) values('w_outer_4','스퀘어 브이넥 골지 가디건',21900);
insert into product(product_code,product_name,product_price) values('w_outer_5','로비아 골지 가디건',24900);
insert into product(product_code,product_name,product_price) values('w_shirts_1','팔레드 뒷 슬릿 블라우스',21900);
insert into product(product_code,product_name,product_price) values('w_shirts_2','팔레드 오버핏 롱 블라우스',21900);
insert into product(product_code,product_name,product_price) values('w_shirts_3','시아 셔링 링클프리 블라우스',24900);
insert into product(product_code,product_name,product_price) values('m_suit_1','AW 솔리드 싱글 수트 (모던타입/히든밴딩)',99000);
insert into product(product_code,product_name,product_price) values('m_suit_10','필슨 오버 싱글 수트',129000);
insert into product(product_code,product_name,product_price) values('m_suit_11','릴렉스드 울 캐시 수트',119000);
insert into product(product_code,product_name,product_price) values('m_suit_12','AW 솔리드 싱글 수트 (히든밴딩)',99000);
insert into product(product_code,product_name,product_price) values('m_suit_2','2color 클래식 체크 수트',129000);
insert into product(product_code,product_name,product_price) values('m_suit_3','AW 세미 오버 스판 수트',109000);
insert into product(product_code,product_name,product_price) values('m_suit_4','브래스 스판 싱글 수트',99000);
insert into product(product_code,product_name,product_price) values('m_suit_5','릴렉스 AW 솔리드 수트 (스트레치원단/히든밴딩)',109000);
insert into product(product_code,product_name,product_price) values('m_suit_6','펜드 투버튼 수트',109000);
insert into product(product_code,product_name,product_price) values('m_suit_7','AW 솔리드 싱글 수트 (심플타입/히든밴딩)',99000);
insert into product(product_code,product_name,product_price) values('m_suit_8','루시 싱글 수트',99000);
insert into product(product_code,product_name,product_price) values('m_suit_9','오르 스판 싱글 수트',109000);
insert into product(product_code,product_name,product_price) values('w_top_1','피네츠 골지 라운드 반팔티',12900);
insert into product(product_code,product_name,product_price) values('w_top_2','데이지 하프넥 반팔티',11900);
insert into product(product_code,product_name,product_price) values('w_top_3','테니 라운드 헤리티',14900);
insert into product(product_code,product_name,product_price) values('w_top_4','리엘 골지 라운드 긴팔티',12900);
insert into product(product_code,product_name,product_price) values('w_top_5','렌느 골지 U넥 긴팔티',12900);
insert into product(product_code,product_name,product_price) values('w_top_6','스프링 스트라이프 긴팔티',12900);
insert into product(product_code,product_name,product_price) values('w_top_7','미유 슬림 롱슬리브티',16900);
insert into product(product_code,product_name,product_price) values('w_top_7','베니 소프트 골지 폴라티',17900);



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

-- product_opt 옵션 더미

insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'XL','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'M','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'M','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'M','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'L','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'L','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'L','아이보리',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'XL','블랙',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'XL','소라',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'XL','아이보리',100);




