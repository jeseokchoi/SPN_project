--table ����
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

-- product/qna ���� --
drop sequence product_review_seq;
drop sequence review_reply_seq;
drop sequence product_seq;
drop sequence cart_seq;
drop sequence product_opt_seq;

drop sequence qna_seq;
drop sequence qna_reply_seq;
drop sequence notice_seq;

-- user/nonuser ���� --
drop sequence nonuserOrder_detail_seq;
drop sequence nonuserOrder_refund_seq;
drop sequence nonuserOrder_exchange_seq;
drop sequence nonuser_order_seq;

drop sequence userOrder_detail_seq;
drop sequence userOrder_refund_seq;
drop sequence user_idx_seq;
drop sequence user_order_seq;
drop sequence userOrder_exchange_idx;

-- product/qna ���� --
create sequence product_review_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence review_reply_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence product_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence product_opt_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence cart_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;

create sequence qna_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence qna_reply_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
create sequence notice_seq start with 1 MAXVALUE 999999 INCREMENT by 1 nocycle NOCACHE;
------------------------------------------------------------------------

-- user/nonuser ���� --
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

-- user���̺� ���� --

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
    user_gender varchar2(20)        check(user_gender in('����','����')) NOT NULL
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

-- userOrder table ����
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
	order_detail_status	varchar(20) default '�ֹ�Ȯ����',
    
    constraint user_order_user
    foreign key(user_id)
    references userTable(user_id)
);
-- deliverAddress table ����

CREATE TABLE deliver_address (
	user_id	varchar2(30)	NOT NULL,
	user_address1	varchar2(20)	NOT NULL,
	user_address2	varchar2(50)	NOT NULL,
	user_address3	varchar2(50)	NOT NULL,
    
    constraint deliver_address_userTable
    FOREIGN key(user_id)
    REFERENCES userTable(user_id)
);
--product table ����
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

--����� ���̺� ����
create table product_t_img (
    product_t_img           varchar2(100)            not null,
    product_idx             number                   not null,   
    
    constraint product_t_img_product
    foreign key(product_idx)
    references product(product_idx)
);

--���̹��� ���̺� ����
create table product_d_img (
    product_d_img           varchar2(100)            not null,
    product_idx             number                   not null,   
    
    constraint product_d_img_product
    foreign key(product_idx)
    references product(product_idx)
);

--��ǰ �ɼ� ���̺� ����
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

--��ٱ��� ���̺� ����
create table cart (
    cart_idx                number            default cart_seq.nextval  primary key,
    product_opt_idx         number            not null,
    cart_value              varchar2(30)      not null,
    product_count           number            default 0 not null, --��ǰ�����ε� 0�̸� �ȵǳ�?
    
    constraint cart_product_opt
    foreign key(product_opt_idx)
    references product_opt(product_opt_idx)
);

--��ǰ���� ���̺� ����
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

--���信 ��� ���̺� ����
create table review_reply (
    review_reply_idx           number           default product_review_seq.nextval  primary key,
    product_review_idx         number           not null,
    content                    varchar2(30)     not null,
    writing_date               date             default sysdate not null,
    
    constraint review_reply_product_review
    foreign key(product_review_idx)
    references product_review(product_review_idx)
);
--userOrder_detail ���̺� ����
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

--userOrder Refund ���̺� ����

CREATE TABLE userOrder_refund (
	userOrder_refund_idx	number	DEFAULT userOrder_refund_seq.nextval primary key,
	userOrder_detail_idx	number	NOT NULL,
	refund_reason	varchar2(3000)	NOT NULL,
	reason_img	varchar2(300)	NOT NULL,
	userOrder_refund_status	varchar(50)	default '�����Ϸ�',
    
    constraint userOrder_refund_userOrder_detail
    FOREIGN key(userOrder_detail_idx)
    REFERENCES userOrder_detail(userOrder_detail_idx)
  
);

CREATE TABLE userOrder_exchange (
	userOrder_exchange_idx	number	DEFAULT userOrder_exchange_idx.nextval,
	userOrder_detail_idx	number	NOT NULL,
	exchange_reason	varchar2(3000)	NOT NULL,
	reason_img	varchar2(300)	NOT NULL,
	userOrder_exchange_status	varchar(50) default '�����Ϸ�',
    
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
	nonuser_order_status	varchar2(50)		default '�ֹ�Ȯ����' ,  
    nonuser_pwd             varchar2(20)        NOT NULL
);
--nonuserOrder detail
CREATE TABLE nonuserOrder_detail (
	nonuserOrder_detail_idx	number	DEFAULT nonuserOrder_detail_seq.nextval primary key,
	product_opt_idx         	number	NOT NULL,
	nonuser_order_idx	    number  NOT NULL,
	
    product_count	number		NOT NULL,
	product_price	number		NOT NULL,
    
    constraint fk_nonuser_order  --  ���������� �̸�
    foreign key(nonuser_order_idx)           --  �ܷ�Ű���� �÷�
    REFERENCES nonuser_order(nonuser_order_idx),    --  �ܷ�Ű�� �����ϴ� ���̺� (�÷�)
           
    constraint fk_product_opt  --  ���������� �̸�
    foreign key(product_opt_idx)           --  �ܷ�Ű���� �÷�
    REFERENCES product_opt(product_opt_idx)    --  �ܷ�Ű�� �����ϴ� ���̺� (�÷�)
       --  �θ�Ű�� ������ ��� ó��  // ��ǰ�� ���ŵǸ� ����ǵ� �������.
);
--nonuserOrder_refund
CREATE TABLE nonuserOrder_refund (
	nonuserOrder_refund_idx	number	DEFAULT nonuserOrder_refund_seq.nextval primary key,
	nonuserOrder_detail_idx	number NOT NULL,
	refund_reason	varchar2(3000)		NOT NULL,
	reason_img	varchar2(300)		NOT NULL,
	nonuserOrder_refund_status	varchar2(50)		default '�����Ϸ�',  -- �̹����� email�� �Ǿ��־ �׷��� ���������.

    constraint fk_nonuserOrder_detail  --  ���������� �̸�
    foreign key(nonuserOrder_detail_idx)           --  �ܷ�Ű���� �÷�
    REFERENCES nonuserOrder_detail(nonuserOrder_detail_idx)    --  �ܷ�Ű�� �����ϴ� ���̺� (�÷�)
);
--nonuserOrder_exchange
CREATE TABLE nonuserOrder_exchange (
	nonuserOrder_exchange_idx	number	DEFAULT nonuserOrder_exchange_seq.nextval primary key,
	nonuserOrder_detail_idx	number NOT NULL,
	exchange_reason	varchar2(3000)		NOT NULL,
	reason_img	varchar2(300)		NOT NULL,
	nonuserOrder_exchange_status	varchar2(50)		default '�����Ϸ�',-- �������ִ� 
    
    constraint fk_nonuserOrder_detail2  --  ���������� �̸�
    foreign key(nonuserOrder_detail_idx)           --  �ܷ�Ű���� �÷�
    REFERENCES nonuserOrder_detail(nonuserOrder_detail_idx)    --  �ܷ�Ű�� �����ϴ� ���̺� (�÷�)

);

insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('UnwtWO37','test1234!@','ȫ��ö','1982-01-13','����','010-3406-5339','UnwtWO37@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('fZrLdG95','test1234!@','�ż���','2000-10-23','����','010-4961-6980','fZrLdG95@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('fwxLHU60','test1234!@','������','1995-02-02','����','010-7370-4980','fwxLHU60@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('CLeLwR82','test1234!@','������','1994-03-15','����','010-7613-2290','CLeLwR82@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('rlReFg93','test1234!@','�����','1996-01-22','����','010-6748-4697','rlReFg93@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('wzBsVc87','test1234!@','����±�','1996-02-15','����','010-2986-4989','wzBsVc87@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('uWgSgq70','test1234!@','�鱤ȣ','1995-01-04','����','010-6455-6164','uWgSgq70@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('pYHZAb59','test1234!@','���ö','1999-12-02','����','010-2668-7560','pYHZAb59@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('dYzsUd66','test1234!@','�ڽ±�','1981-08-07','����','010-4780-8207','dYzsUd66@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('zPVaYB33','test1234!@','Ȳ����','1997-01-04','����','010-7809-4157','zPVaYB33@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('YGshpn97','test1234!@','���','1990-11-28','����','010-4554-7828','YGshpn97@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('dUteJB40','test1234!@','�ȵ���','1987-07-06','����','010-4124-7184','dUteJB40@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('KgcCXs43','test1234!@','��ȿ��','2002-09-13','����','010-8742-7149','KgcCXs43@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('EOHmJC56','test1234!@','������','1995-11-01','����','010-8857-2235','EOHmJC56@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('DMKnnD87','test1234!@','������','1992-10-22','����','010-3188-6252','DMKnnD87@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('nZeBmC16','test1234!@','������','1984-10-26','����','010-7297-2181','nZeBmC16@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('gpLvvj41','test1234!@','������','1997-07-27','����','010-3823-4594','gpLvvj41@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('rHtSTI72','test1234!@','���ؿ�','1988-11-16','����','010-7755-7016','rHtSTI72@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('cvsxVu92','test1234!@','������','1988-02-05','����','010-2900-2104','cvsxVu92@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('zDiPIW83','test1234!@','�鼺ȣ','1999-02-01','����','010-3525-1417','zDiPIW83@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('wwTnsG55','test1234!@','��ȫ��','1991-10-07','����','010-8205-7510','wwTnsG55@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('ScePkt52','test1234!@','������','1980-10-13','����','010-7939-7426','ScePkt52@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('WKwBhF62','test1234!@','������','1995-07-27','����','010-4782-8225','WKwBhF62@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('OWrOwJ79','test1234!@','�������','1984-08-05','����','010-5717-2165','OWrOwJ79@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('IHgEAW25','test1234!@','���¼�','1991-11-01','����','010-3082-7436','IHgEAW25@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('XcSZni35','test1234!@','������','1995-06-12','����','010-7609-1522','XcSZni35@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('NcSBdD29','test1234!@','�輮��','1990-12-10','����','010-9564-2632','NcSBdD29@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('SrsSEL34','test1234!@','������','2003-06-05','����','010-5998-8609','SrsSEL34@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('glhJAQ84','test1234!@','�������','1999-03-29','����','010-4668-3799','glhJAQ84@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('sjKXlm25','test1234!@','������','1987-01-28','����','010-5932-3426','sjKXlm25@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('WsjgUg67','test1234!@','Ȳ�缷','1981-06-11','����','010-5540-9783','WsjgUg67@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('dwPlKf63','test1234!@','��ö��','2000-01-02','����','010-8854-9691','dwPlKf63@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('IUBYjr86','test1234!@','Ȳ���汸','1997-12-12','����','010-4712-4447','IUBYjr86@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('xoFTmj2','test1234!@','��ö��','1980-10-03','����','010-2238-8198','xoFTmj2@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('gBOxjO33','test1234!@','�߹���','1990-02-15','����','010-5257-7485','gBOxjO33@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('oNaynr78','test1234!@','ǳ����','1988-08-20','����','010-1050-7727','oNaynr78@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('EzMXPG3','test1234!@','�����','1992-11-06','����','010-2058-1385','EzMXPG3@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('kLUpoq33','test1234!@','�ϱ���','2003-03-09','����','010-9459-9410','kLUpoq33@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('pZEoCz88','test1234!@','Ȳö��','1994-12-18','����','010-8736-9845','pZEoCz88@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('DrOGnG62','test1234!@','�����','1992-08-16','����','010-8841-2706','DrOGnG62@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('VTOjAT49','test1234!@','������','1980-06-07','����','010-3157-2462','VTOjAT49@naver.com','N','user','gold');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('XJyCZZ61','test1234!@','������','1992-05-07','����','010-6514-2237','XJyCZZ61@naver.com','N','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('fcrovy98','test1234!@','�����','1984-01-20','����','010-7699-4335','fcrovy98@naver.com','N','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('EItSUp52','test1234!@','������','1992-12-17','����','010-8484-6762','EItSUp52@naver.com','N','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('eDpBpw6','test1234!@','Ź����','1980-09-06','����','010-9802-4978','eDpBpw6@naver.com','N','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('wYhyME2','test1234!@','Ȳ�缷','1980-03-05','����','010-2615-7301','wYhyME2@naver.com','N','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('JKHESW34','test1234!@','������','1998-10-12','����','010-5931-8894','JKHESW34@naver.com','N','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('ovRTAz44','test1234!@','�����','1986-02-05','����','010-1239-2884','ovRTAz44@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('CsoHlu97','test1234!@','������','1985-06-10','����','010-7768-6226','CsoHlu97@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('vZCDbi97','test1234!@','��ġ��','1985-03-14','����','010-6681-3192','vZCDbi97@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('VTEKpP32','test1234!@','���ð汸','1994-04-28','����','010-3702-6600','VTEKpP32@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('trOGTA24','test1234!@','������','1988-12-27','����','010-3486-8016','trOGTA24@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('nKpupq15','test1234!@','������','1997-10-07','����','010-3028-4986','nKpupq15@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('hESTaB30','test1234!@','���缷','1994-04-18','����','010-4660-7437','hESTaB30@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('baNJKX15','test1234!@','���ϼ�','1990-02-09','����','010-9714-6232','baNJKX15@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('kEAtoR65','test1234!@','�����','1993-11-24','����','010-9618-1601','kEAtoR65@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('wvDnWb84','test1234!@','������','2002-10-05','����','010-6039-6605','wvDnWb84@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('WJueMS21','test1234!@','����ġ��','1982-07-09','����','010-1676-2820','WJueMS21@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('ogFdTo20','test1234!@','��ġ��','1988-02-25','����','010-6673-8114','ogFdTo20@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('AzPciG70','test1234!@','��ġ��','1981-04-20','����','010-9465-5905','AzPciG70@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('WzUdCc60','test1234!@','���Ҷ�','1999-11-02','����','010-3267-3406','WzUdCc60@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('mjRDRm11','test1234!@','���ܵ�','1984-10-19','����','010-7049-4904','mjRDRm11@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('lAujbT96','test1234!@','�̴���','1983-07-25','����','010-3273-8734','lAujbT96@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('kztVZt81','test1234!@','�������','1999-02-27','����','010-9100-6374','kztVZt81@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('xrdGjI5','test1234!@','������','1991-04-09','����','010-5409-6290','xrdGjI5@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('mheOMS15','test1234!@','ǥ�Ʒ�','2002-11-14','����','010-6144-8937','mheOMS15@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('HMWkJe42','test1234!@','���̽�','1990-08-11','����','010-6694-1143','HMWkJe42@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('SVtlop17','test1234!@','�ּҸ�','1981-03-08','����','010-3639-9093','SVtlop17@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('dnRFMX55','test1234!@','Ȳ�Ϸ�','1994-07-09','����','010-8004-9226','dnRFMX55@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('ArzZSm10','test1234!@','���ڶ�','1993-04-10','����','010-9396-9807','ArzZSm10@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('MZvhZi26','test1234!@','�߳���','1984-02-13','����','010-7436-1360','MZvhZi26@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('zPGuUK34','test1234!@','������','1986-09-12','����','010-3822-1037','zPGuUK34@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('qVNwgH95','test1234!@','���Ƹ�','1994-07-24','����','010-4563-1151','qVNwgH95@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('oYAqbb1','test1234!@','���ε鷹','2003-01-20','����','010-4149-8492','oYAqbb1@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('jdAuXP97','test1234!@','�Ű���','1985-05-26','����','010-5869-3910','jdAuXP97@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('XaCPzj99','test1234!@','�躸��','1995-11-06','����','010-3160-4273','XaCPzj99@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('HeNkgE81','test1234!@','���ѻ�','1997-06-14','����','010-9240-5753','HeNkgE81@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('tVXDXC30','test1234!@','��ƶ�','1981-05-28','����','010-8671-6440','tVXDXC30@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('LStNSZ90','test1234!@','���','1995-11-25','����','010-9553-7800','LStNSZ90@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('ernGLF68','test1234!@','���޺�','1980-05-11','����','010-7139-8494','ernGLF68@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('kdqLJe48','test1234!@','�ձ��','1990-04-28','����','010-3777-7355','kdqLJe48@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('pkOCwk5','test1234!@','�۵θ�','1986-04-30','����','010-1605-4019','pkOCwk5@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('yoztKG24','test1234!@','������','1999-03-01','����','010-7310-5059','yoztKG24@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('HUTEIN97','test1234!@','������','1997-05-22','����','010-2742-3865','HUTEIN97@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('hIbeRR98','test1234!@','�۱���','1990-03-07','����','010-2273-5457','hIbeRR98@naver.com','Y','user','silver');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('qolOaA24','test1234!@','���θ�','2001-06-15','����','010-4129-7501','qolOaA24@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('jqfSLv55','test1234!@','������','1993-12-07','����','010-9370-3448','jqfSLv55@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('xifHmX30','test1234!@','���ʷ�','1994-05-01','����','010-8988-6212','xifHmX30@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('iuXvxb50','test1234!@','�����ϴ�','1981-04-24','����','010-5569-7525','iuXvxb50@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('JpyLGs26','test1234!@','������','1995-01-30','����','010-7722-3077','JpyLGs26@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('onOzMc39','test1234!@','���ٿ�','1989-09-24','����','010-3288-1088','onOzMc39@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('zoraHk37','test1234!@','������','1996-01-08','����','010-1835-1894','zoraHk37@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('FvLCIa13','test1234!@','����','1999-01-04','����','010-8519-4797','FvLCIa13@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('YBKnXk66','test1234!@','���ѱ�','1998-06-11','����','010-4580-6266','YBKnXk66@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('prCLTb96','test1234!@','��̸�','1986-03-26','����','010-8895-5334','prCLTb96@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('MtUdiA8','test1234!@','���ó���','1989-02-07','����','010-1463-2478','MtUdiA8@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('FvDhzH99','test1234!@','���̸�','1994-10-27','����','010-3061-4499','FvDhzH99@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('FwGLoS28','test1234!@','������','1997-04-09','����','010-3923-9786','FwGLoS28@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('bOuIGy97','test1234!@','���ٿ�','1980-06-22','����','010-9356-2723','bOuIGy97@naver.com','Y','user','bronze');
insert into userTable (user_id, user_pwd, user_name, user_birth, user_gender, user_phone, user_email, email_check, user_role, user_grade) values('ixAXRA11','test1234!@','�Ϲ���','1998-01-06','����','010-5088-4523','ixAXRA11@naver.com','Y','user','bronze');

insert into product(product_code,product_name,product_price) values('m_top_1','�õ��� ������ Ƽ���� -���� ������',24900);
insert into product(product_code,product_name,product_price) values('m_top_2','������ ���̾�� ���� Ƽ����',12900);
insert into product(product_code,product_name,product_price) values('m_top_3','��긯 Ʈ���̴� �ĵ�',49900);
insert into product(product_code,product_name,product_price) values('m_top_4','ĳ��� ���͸� ������',32900);
insert into product(product_code,product_name,product_price) values('m_top_5','�𳪹� ������ ������',19900);
insert into product(product_code,product_name,product_price) values('m_top_6','���� ������ �޸� ������',27900);
insert into product(product_code,product_name,product_price) values('m_top_7','�õ��� ������ Ƽ���� -���� ������',24900);
insert into product(product_code,product_name,product_price) values('m_top_8','���� �� ���� Ƽ����',19900);
insert into product(product_code,product_name,product_price) values('m_top_9','���ϸ� ���� �ս�����',17900);
insert into product(product_code,product_name,product_price) values('m_top_10','���� ���� �� ������ Ƽ����',19900);
insert into product(product_code,product_name,product_price) values('m_top_11','����Ʈ ���� ����Ƽ',19900);
insert into product(product_code,product_name,product_price) values('m_top_12','�÷��� ���� ������',44900);
insert into product(product_code,product_name,product_price) values('m_top_13','����Ǯ ��Ŭ���� ���� ����Ƽ',12900);
insert into product(product_code,product_name,product_price) values('m_top_14','���Ĵٵ� �� ������',16900);
insert into product(product_code,product_name,product_price) values('m_top_15','������ ���� ���� Ƽ����',27900);
insert into product(product_code,product_name,product_price) values('m_top_16','������ ���� ������',34900);
insert into product(product_code,product_name,product_price) values('m_top_17','������ Ʈ����Ʈ ��������Ƽ',34900);
insert into product(product_code,product_name,product_price) values('m_top_18','8color ���ϸ� ������ ��ƮƼ',32900);
insert into product(product_code,product_name,product_price) values('m_top_19','���ϸ� ��ź Ƽ����',15900);
insert into product(product_code,product_name,product_price) values('m_top_20','��� �� ������ - 2�� ������',21900);
insert into product(product_code,product_name,product_price) values('m_top_21','������ ���� ���� Ƽ���� [�ƽ�Ų����]',29900);
insert into product(product_code,product_name,product_price) values('m_top_22','������ ���� ����Ƽ',24900);
insert into product(product_code,product_name,product_price) values('m_top_23','4color ������ ��ƮƼ',29900);
insert into product(product_code,product_name,product_price) values('m_shoes_1','2color ���� ���� �����(�Ұ���)',56800);
insert into product(product_code,product_name,product_price) values('m_shoes_2','2color ��뷱�� ������',82800);
insert into product(product_code,product_name,product_price) values('m_shoes_3','3color ��ư��Ʈ�� �ø��ö�',42800);
insert into product(product_code,product_name,product_price) values('m_shoes_4','���Ϸ� ���� Ŭ����',52800);
insert into product(product_code,product_name,product_price) values('m_shoes_5','��Ʈ�� ����Ŀ��',49800);
insert into product(product_code,product_name,product_price) values('m_shoes_6','����Ʈ �������� ���� ���� ����',64800);
insert into product(product_code,product_name,product_price) values('m_shoes_7','���󷹴� �ؽ��� ����Ŀ��',101800);
insert into product(product_code,product_name,product_price) values('m_shoes_8','���� ���� ��Ϸ���',58000);
insert into product(product_code,product_name,product_price) values('m_shoes_9','��Ƽġ ���� �� ����',117000);
insert into product(product_code,product_name,product_price) values('m_shoes_10','���� ÿ�ú���',56000);
insert into product(product_code,product_name,product_price) values('m_shoes_11','���� �޽� ����Ŀ��',131000);
insert into product(product_code,product_name,product_price) values('m_shoes_12','�̴ϸ� ���ϱ� ����Ŀ��',54000);
insert into product(product_code,product_name,product_price) values('m_shoes_13','���̵� ���� ĵ����',44000);
insert into product(product_code,product_name,product_price) values('m_shoes_14','�귻�� ÿ�ú���',59900);
insert into product(product_code,product_name,product_price) values('m_shoes_15','���� ���� Ŭ����',149000);
insert into product(product_code,product_name,product_price) values('m_shoes_16','�丮 �������� ����',64000);
insert into product(product_code,product_name,product_price) values('m_shoes_17','SS ��Ƽġ ���� ����',59900);
insert into product(product_code,product_name,product_price) values('m_shoes_18','������ ��Ϸ��� - 3�� ������',57900);
insert into product(product_code,product_name,product_price) values('m_shoes_19','��Ƽġ ���� ����',59900);
insert into product(product_code,product_name,product_price) values('m_shoes_20','CP ������ �ο� ����Ŀ��(ȭ��Ʈ) - 5�� ������',39900);
insert into product(product_code,product_name,product_price) values('m_shirts_1','�÷��� ��ư ����',39900);
insert into product(product_code,product_name,product_price) values('m_shirts_2','�̴ϸ� ���� ī�� ����',42900);
insert into product(product_code,product_name,product_price) values('m_shirts_3','��� ũ�� ����',44900);
insert into product(product_code,product_name,product_price) values('m_shitrs_4','���ϸ� Ÿź üũ ����',24900);
insert into product(product_code,product_name,product_price) values('m_shirts_5','Basic ��ư ����',45900);
insert into product(product_code,product_name,product_price) values('m_shirts_6','���� �������� ����',44900);
insert into product(product_code,product_name,product_price) values('m_shirts_7','���̽� �̴ϸ� ����',34900);
insert into product(product_code,product_name,product_price) values('m_shirts_8','������ ���ø� ����',29900);
insert into product(product_code,product_name,product_price) values('m_shirts_9','���� ���� ����',27900);
insert into product(product_code,product_name,product_price) values('m_shirts_10','6color ���Ĵٵ� ����',32900);
insert into product(product_code,product_name,product_price) values('m_shirts_11','9color ��Ŭ���� ���� ����',24900);
insert into product(product_code,product_name,product_price) values('m_shirts_12','7color ��Ŭ���� ���� ����',22900);
insert into product(product_code,product_name,product_price) values('m_shirts_13','���� ��Ŭ���� ����',24900);
insert into product(product_code,product_name,product_price) values('m_shirts_14','������ �������� ����(����Ÿ��)',21900);
insert into product(product_code,product_name,product_price) values('m_shirts_15','������ ��Ÿ�Ϸ� ����',24900);
insert into product(product_code,product_name,product_price) values('m_shirrs_16','9color ��Ŭ���� ���� ����',24900);
insert into product(product_code,product_name,product_price) values('m_shirts_17','�Ŵ� �ָ��� ��������',27900);
insert into product(product_code,product_name,product_price) values('m_shirts_18','������ ��Ŭ���� ����(����Ÿ��)',24900);
insert into product(product_code,product_name,product_price) values('m_shirts_19','������ ��Ŭ���� ���� ����',24900);
insert into product(product_code,product_name,product_price) values('m_pants_1','5color ��ư ��� ����',39900);
insert into product(product_code,product_name,product_price) values('m_pants_2','�Ͽ콺 �ټ� ������ (�������/������)',39900);
insert into product(product_code,product_name,product_price) values('m_pants_3','��긯 Ʈ���̴� ����',44900);
insert into product(product_code,product_name,product_price) values('m_pants_4','���� �� ���̵� ������',44900);
insert into product(product_code,product_name,product_price) values('m_pants_5','���� ���ַ� ��� ������',44900);
insert into product(product_code,product_name,product_price) values('m_pants_6','AW ���� ���� ��� ������',34900);
insert into product(product_code,product_name,product_price) values('m_pants_7','�η� �����۵� ��ư����',39900);
insert into product(product_code,product_name,product_price) values('m_pants_8','���ϸ� ��� �� ������',39900);
insert into product(product_code,product_name,product_price) values('m_pants_9','��� ���̵� ������',47900);
insert into product(product_code,product_name,product_price) values('m_pants_10','���ϸ� ���Ĵٵ� ����',49900);
insert into product(product_code,product_name,product_price) values('m_pants_11','3color ũ�� ���� ����',49900);
insert into product(product_code,product_name,product_price) values('m_pants_12','���� ��ư ġ�� ����',32900);
insert into product(product_code,product_name,product_price) values('m_pants_13','��ũ ������',47900);
insert into product(product_code,product_name,product_price) values('m_pants_14','��Ʈ ���� ���̵� ������',29900);
insert into product(product_code,product_name,product_price) values('m_pants_15','���� ���� ������',34900);
insert into product(product_code,product_name,product_price) values('m_pants_16','���� ���̿��̵� ������',37900);
insert into product(product_code,product_name,product_price) values('m_pants_17','�ι� ���� ��������',44900);
insert into product(product_code,product_name,product_price) values('m_pants_18','���α� ���̵� ������',49900);
insert into product(product_code,product_name,product_price) values('m_pants_19','��Ƽ�� ���̵� ������',34900);
insert into product(product_code,product_name,product_price) values('m_pants_20','2color Ŭ���� üũ ������',45900);
insert into product(product_code,product_name,product_price) values('m_pants_21','�θ� Ʈ�� �������� - BLACK',52900);
insert into product(product_code,product_name,product_price) values('m_pants_22','��� ���� ��� ������',34900);
insert into product(product_code,product_name,product_price) values('m_pants_23','�и� ���̵� ��������',34900);
insert into product(product_code,product_name,product_price) values('m_pants_24','������ ���̵� ���� ������',39900);
insert into product(product_code,product_name,product_price) values('m_pants_25','���� ���� ���� ����',49900);
insert into product(product_code,product_name,product_price) values('m_pants_26','��ư �ڵ���� �������',24900);
insert into product(product_code,product_name,product_price) values('m_pants_27','��ũ�� ��� ������',34900);
insert into product(product_code,product_name,product_price) values('m_pants_28','���� ��Ʈ�� ���̵� ������',29900);
insert into product(product_code,product_name,product_price) values('m_pants_29','������ ��Ʈ����Ʈ ���� ���� by showpin (Ŀ��Ÿ��)',49900);
insert into product(product_code,product_name,product_price) values('m_pants_30','�븣�� ��ư ����',37900);
insert into product(product_code,product_name,product_price) values('m_pants_31','������ ��� ��ư����',34900);
insert into product(product_code,product_name,product_price) values('m_pants_32','�ָ��� ���̿��̵� ������',32900);
insert into product(product_code,product_name,product_price) values('m_pants_33','��Ʈ ������ ������',29900);
insert into product(product_code,product_name,product_price) values('m_outer_1','�ʽ� ���� ������',94900);
insert into product(product_code,product_name,product_price) values('m_outer_2','���ϵ� �ĵ� ����',39900);
insert into product(product_code,product_name,product_price) values('m_outer_3','����ī �ǽ����� �߻��е�',99000);
insert into product(product_code,product_name,product_price) values('m_outer_4','������ ���� �װ� ����',44900);
insert into product(product_code,product_name,product_price) values('m_outer_5','��ư ��Ʈ ī�� ����',59900);
insert into product(product_code,product_name,product_price) values('m_outer_6','�ε� ������ ����� (~3XL)',29900);
insert into product(product_code,product_name,product_price) values('m_outer_7','���� �� ���� ��Ʈ',89900);
insert into product(product_code,product_name,product_price) values('m_outer_8','���� �� �̱� ��Ʈ',89900);
insert into product(product_code,product_name,product_price) values('m_outer_9','�������� �� ĳ�� ����',89900);
insert into product(product_code,product_name,product_price) values('m_outer_10','�ָ��� �� ĳ�ù̾� ���� �̱� ��Ʈ',109000);
insert into product(product_code,product_name,product_price) values('m_outer_11','8color Ŭ���� ���̿��� ����',79900);
insert into product(product_code,product_name,product_price) values('m_outer_12','������ ���� ���� ����',59900);
insert into product(product_code,product_name,product_price) values('m_outer_13','AW �ָ��� �̱� ����',79000);
insert into product(product_code,product_name,product_price) values('m_outer_14','���� ��Ʈ ��������',39900);
insert into product(product_code,product_name,product_price) values('m_outer_15','���� ���� ����',57900);
insert into product(product_code,product_name,product_price) values('m_outer_16','���� ��Ʈ Ǯ����',39900);
insert into product(product_code,product_name,product_price) values('m_outer_17','14color ������ ĳ�־� �����',39900);
insert into product(product_code,product_name,product_price) values('m_outer_18','AW �� ĳ�ù̾� �̱�/���� ��Ʈ',99000);
insert into product(product_code,product_name,product_price) values('m_outer_19','���ϸ� ���� Ʈ��ġ ��Ʈ',72900);
insert into product(product_code,product_name,product_price) values('m_outer_20','����� 3��ư �̱� ��Ʈ',69900);
insert into product(product_code,product_name,product_price) values('m_knit_1','����Ʈ ��ư�� ĳ�� ��Ʈ',39900);
insert into product(product_code,product_name,product_price) values('m_knit_2','���� ���� usa ��Ʈ',39900);
insert into product(product_code,product_name,product_price) values('m_knit_3','2 Type ��Ʋ�� ���� ��Ʈ - 2�� ������',24900);
insert into product(product_code,product_name,product_price) values('m_knit_4','������ ��ư ��Ʋ�� ��Ʈ',39900);
insert into product(product_code,product_name,product_price) values('m_knit_5','��Ƽ ���̺� ���̳� ��Ʈ',39900);
insert into product(product_code,product_name,product_price) values('m_knit_6','ĳ�� ������ �����Ʈ',44900);
insert into product(product_code,product_name,product_price) values('m_knit_7','������ �������� ��Ʈ',44900);
insert into product(product_code,product_name,product_price) values('m_knit_8','��� ����� ��Ʈ',44900);
insert into product(product_code,product_name,product_price) values('m_knit_9','Ŭ���� ���� Ʈ�� ��Ʈ',29900);
insert into product(product_code,product_name,product_price) values('m_knit_10','���ø� ���� ��Ʈ',34900);
insert into product(product_code,product_name,product_price) values('m_knit_11','ĳ�� ���̺� ���� ��Ʈ',44900);
insert into product(product_code,product_name,product_price) values('m_knit_12','�񿣴� V�� ��Ʈ',34900);
insert into product(product_code,product_name,product_price) values('m_knit_13','�˷� ���³� ��Ʈ',34900);
insert into product(product_code,product_name,product_price) values('m_knit_14','���� ���� ĳ�� �����Ʈ',44900);
insert into product(product_code,product_name,product_price) values('m_knit_15','�ָ��� ���� ��Ʈ - 2�� ������',24900);
insert into product(product_code,product_name,product_price) values('m_knit_16','����Ʈ ����� ī���Ʈ',57900);
insert into product(product_code,product_name,product_price) values('m_knit_17','����Ʈ �������� ��ƮƼ',19900);
insert into product(product_code,product_name,product_price) values('m_knit_18','���� ���Ĵٵ� ���� ��Ʈ',29900);
insert into product(product_code,product_name,product_price) values('m_knit_19','���Ĵٵ� ��Ƽ�ʸ� ��ƮƼ (��Ǯ����)',32900);
insert into product(product_code,product_name,product_price) values('m_knit_20','���� ���Ĵٵ� ������ ��Ʈ',29900);
insert into product(product_code,product_name,product_price) values('m_knit_21','���� ���ø� ��Ʈ',27900);
insert into product(product_code,product_name,product_price) values('w_bottom_1','���� ���̵� ���� ������',29900);
insert into product(product_code,product_name,product_price) values('w_bottom_10','2 Type ��Ű ���̿���Ʈ ������ (~4XL)',29900);
insert into product(product_code,product_name,product_price) values('w_bottom_11','������ ��Ʈ����Ʈ�� ���� (������)',27900);
insert into product(product_code,product_name,product_price) values('w_bottom_2','���� A���� ��ĿƮ',19900);
insert into product(product_code,product_name,product_price) values('w_bottom_3','���� ���̿��̵� ��ư����',21900);
insert into product(product_code,product_name,product_price) values('w_bottom_4','���� ���� ũ�� ������',32000);
insert into product(product_code,product_name,product_price) values('w_bottom_5','������ ũ�� ���� ����',29900);
insert into product(product_code,product_name,product_price) values('w_bottom_6','��� ����ư ���̿���Ʈ ������',27900);
insert into product(product_code,product_name,product_price) values('w_bottom_7','������ ������ ���� (������)',27900);
insert into product(product_code,product_name,product_price) values('w_bottom_8','����� ���� ���̵� ������',27900);
insert into product(product_code,product_name,product_price) values('w_bottom_9','��Ÿ �޹�� ���̵� ������',29900);
insert into product(product_code,product_name,product_price) values('w_knit_1','��ο� ���� ���� ��Ʈ',19000);
insert into product(product_code,product_name,product_price) values('w_knit_2','��ο� ���̳� ���� ��Ʈ',19900);
insert into product(product_code,product_name,product_price) values('w_knit_3','�κ�� ���� �����',24900);
insert into product(product_code,product_name,product_price) values('w_outer_1','���� ī�� ��� �����',34900);
insert into product(product_code,product_name,product_price) values('w_outer_2','�̺� ī�� ��Ʈ����',37900);
insert into product(product_code,product_name,product_price) values('w_outer_3','��Ƽ ��Ʈ������ ���� �����',39900);
insert into product(product_code,product_name,product_price) values('w_outer_4','������ ���̳� ���� �����',21900);
insert into product(product_code,product_name,product_price) values('w_outer_5','�κ�� ���� �����',24900);
insert into product(product_code,product_name,product_price) values('w_shirts_1','�ȷ��� �� ���� ���콺',21900);
insert into product(product_code,product_name,product_price) values('w_shirts_2','�ȷ��� ������ �� ���콺',21900);
insert into product(product_code,product_name,product_price) values('w_shirts_3','�þ� �Ÿ� ��Ŭ���� ���콺',24900);
insert into product(product_code,product_name,product_price) values('m_suit_1','AW �ָ��� �̱� ��Ʈ (���Ÿ��/������)',99000);
insert into product(product_code,product_name,product_price) values('m_suit_10','�ʽ� ���� �̱� ��Ʈ',129000);
insert into product(product_code,product_name,product_price) values('m_suit_11','�������� �� ĳ�� ��Ʈ',119000);
insert into product(product_code,product_name,product_price) values('m_suit_12','AW �ָ��� �̱� ��Ʈ (������)',99000);
insert into product(product_code,product_name,product_price) values('m_suit_2','2color Ŭ���� üũ ��Ʈ',129000);
insert into product(product_code,product_name,product_price) values('m_suit_3','AW ���� ���� ���� ��Ʈ',109000);
insert into product(product_code,product_name,product_price) values('m_suit_4','�귡�� ���� �̱� ��Ʈ',99000);
insert into product(product_code,product_name,product_price) values('m_suit_5','������ AW �ָ��� ��Ʈ (��Ʈ��ġ����/������)',109000);
insert into product(product_code,product_name,product_price) values('m_suit_6','��� ����ư ��Ʈ',109000);
insert into product(product_code,product_name,product_price) values('m_suit_7','AW �ָ��� �̱� ��Ʈ (����Ÿ��/������)',99000);
insert into product(product_code,product_name,product_price) values('m_suit_8','��� �̱� ��Ʈ',99000);
insert into product(product_code,product_name,product_price) values('m_suit_9','���� ���� �̱� ��Ʈ',109000);
insert into product(product_code,product_name,product_price) values('w_top_1','�ǳ��� ���� ���� ����Ƽ',12900);
insert into product(product_code,product_name,product_price) values('w_top_2','������ ������ ����Ƽ',11900);
insert into product(product_code,product_name,product_price) values('w_top_3','�״� ���� �츮Ƽ',14900);
insert into product(product_code,product_name,product_price) values('w_top_4','���� ���� ���� ����Ƽ',12900);
insert into product(product_code,product_name,product_price) values('w_top_5','���� ���� U�� ����Ƽ',12900);
insert into product(product_code,product_name,product_price) values('w_top_6','������ ��Ʈ������ ����Ƽ',12900);
insert into product(product_code,product_name,product_price) values('w_top_7','���� ���� �ս�����Ƽ',16900);
insert into product(product_code,product_name,product_price) values('w_top_7','���� ����Ʈ ���� ����Ƽ',17900);



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

-- product_opt �ɼ� ����

insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(1,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(2,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(3,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(4,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(5,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(6,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(7,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(8,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(9,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(10,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(11,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(12,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(13,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(14,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(15,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(16,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(17,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(18,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(19,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(20,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(21,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(22,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(23,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(24,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(25,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(26,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(27,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(28,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(29,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(30,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(31,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(32,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(33,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(34,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(35,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(36,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(37,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(38,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(39,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(40,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(41,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(42,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(43,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(44,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(45,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(46,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(47,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(48,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(49,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(50,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(51,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(52,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(53,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(54,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(55,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(56,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(57,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(58,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(59,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(60,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(61,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(62,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(63,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(64,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(65,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(66,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(67,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(68,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(69,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(70,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(71,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(72,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(73,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(74,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(75,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(76,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(77,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(78,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(79,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(80,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(81,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(82,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(83,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(84,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(85,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(86,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(87,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(88,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(89,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(90,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(91,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(92,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(93,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(94,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(95,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(96,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(97,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(98,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(99,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(100,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(101,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(102,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(103,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(104,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(105,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(106,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(107,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(108,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(109,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(110,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(111,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(112,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(113,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(114,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(115,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(116,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(117,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(118,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(119,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(120,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(121,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(122,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(123,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(124,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(125,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(126,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(127,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(128,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(129,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(130,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(131,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(132,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(133,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(134,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(135,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(136,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(137,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(138,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(139,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(140,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(141,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(142,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(143,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(144,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(145,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(146,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(147,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(148,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(149,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(150,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(151,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(152,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(153,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(154,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(155,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(156,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(157,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(158,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(159,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(160,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(161,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(162,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(163,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(164,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(165,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(166,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(167,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(168,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(169,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(170,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(171,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(172,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(173,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(174,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(175,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(176,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(177,'XL','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'M','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'M','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'M','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'L','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'L','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'L','���̺���',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'XL','��',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'XL','�Ҷ�',100);
insert into product_opt(product_idx,product_size,product_color,product_stock) values(178,'XL','���̺���',100);




