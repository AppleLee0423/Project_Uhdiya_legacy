DROP TABLE MEMBER;
DROP TABLE ADDRESS;

DROP TABLE PRODUCT;
DROP TABLE PRODUCT_FILE;

DROP TABLE U_ORDER;
DROP TABLE CART;

DROP TABLE NOTICE;
DROP TABLE NOTICE_FILE;
DROP TABLE QNA;
DROP TABLE QNA_FILE;
DROP TABLE REVIEW;
DROP TABLE REVIEW_FILE;

DROP SEQUENCE mem_seq;
DROP SEQUENCE pro_seq;
DROP SEQUENCE proFile_seq;
DROP SEQUENCE u_order_seq;
DROP SEQUENCE cart_seq;

-- ȸ������ ���̺�
CREATE TABLE MEMBER (
    ID NUMBER NOT NULL,
    MEMBER_ID VARCHAR2(255) NOT NULL PRIMARY KEY, -- ���� ���̵�
    MEMBER_PASSWORD VARCHAR2(255), -- ���� ��й�ȣ
    MEMBER_NAME VARCHAR2(255), -- ���� �̸�
    MEMBER_PHONE VARCHAR2(255) UNIQUE NOT NULL, -- ���� ��ȭ��ȣ(PHONE1+PHONE2_PHONE3)
    MEMBER_EMAIL VARCHAR2(255) UNIQUE NOT NULL, -- ���� �̸���
    MEMBER_JOINDATE DATE DEFAULT SYSDATE-- ���� ��������
);

CREATE TABLE ADDRESS (
    MEMBER_ID VARCHAR2(255) NOT NULL PRIMARY KEY,
    ZIPNO VARCHAR2(255),
    ROADFULLADDR VARCHAR2(255), --���θ�(����) �ּ�
    ADDDETAIL varchar2(255) -- ���ּ�
);

-- ��ǰ ���̺�
CREATE TABLE PRODUCT (
    PRODUCT_ID NUMBER NOT NULL,
    PRODUCT_CODE VARCHAR2(255) NOT NULL, -- ��ǰ�����ڵ�
    PRODUCT_NAME VARCHAR2(255), -- ��ǰ��
    PRODUCT_CATEL VARCHAR2(255), -- ��з�
    PRODUCT_CATES VARCHAR2(255), -- �Һз�
    PRODUCT_PRICE NUMBER, -- ��ǰ����
    CONSTRAINT PK_product PRIMARY KEY (product_code)
);

-- ��ǰ �̹��� ���̺�
CREATE TABLE PRODUCT_FILE (
    PRODUCT_FILEID NUMBER NOT NULL,
    PRODUCT_FILENAME VARCHAR2(255), --���ϸ�
    PRODUCT_FILETYPE VARCHAR2(255), -- main(��ǰ����) �Ǵ� info(��ǰ�󼼼������)
    PRODUCT_CODE VARCHAR2(255) NOT NULL, -- ��ǰ�����ڵ� (product���̺�)
    CONSTRAINT PK_product_file PRIMARY KEY (product_fileId),
    CONSTRAINT FK_product_TO_product_file
        FOREIGN KEY (product_code)
        REFERENCES product (product_code)
);

-- ��ٱ��� ���̺�
CREATE TABLE CART (
    CART_SEQ_NUM NUMBER NOT NULL PRIMARY KEY,-- ������ �ڵ���ȣ
    MEMBER_ID VARCHAR2(255) NOT NULL, -- ���̵�
    PRODUCT_CODE VARCHAR2(255) NOT NULL, --��ǰ�����ڵ� (product ���̺� ����)
    CARY_QTY NUMBER NOT NULL -- ��ٱ��� ����(ǰ���
);

-- ���� ���̺�
CREATE TABLE U_ORDER (
    ORDER_SEQ_NUM NUMBER NOT NULL PRIMARY KEY, -- ������ �ڵ���ȣ
    ORDER_ID VARCHAR2(255) NOT NULL, -- ���Ű�����ȣ(�ֹ���ȣ) (@ ����ǰ���̾ �ѹ�ȣ��) 
    MEMBER_ID VARCHAR2(255) NOT NULL, -- ���̵�
    PRODUCT_CODE VARCHAR2(255) NOT NULL, --��ǰ�����ڵ�
    ORDER_QTY NUMBER NOT NULL, -- ���� ����(ǰ���)
    ORDER_DATE DATE, -- �������� -> �ֹ����ۼ� �Ϸ�� ����
    ORDER_STATE VARCHAR2(255) DEFAULT 'onorder' -- ����( 'onorder' , 'ordered' , 'paid' )
);

-- �ּ�
CREATE TABLE ADDRESS (
    RECEIVER_ZIPCODE VARCHAR2(13),
    RECEIVER_ADDR1 VARCHAR2(255),
    RECEIVER_ADDR2 VARCHAR2(255)
);

-- ��������
Create Table notice(
    notice_id number not null primary key,
    notice_writeId varchar2(255) not null,
    notice_title varchar2(255),
    notice_content varchar2(4000),
    notice_regDate date default sysdate not null,
    notice_count number default 0
);

-- �������� �̹��� ���̺�
create table notice_file(
    notice_fileId number not null primary key,
    notice_id number,
    notice_fileName varchar2(255)
);

-- ���Ǳ�
create table qna (
    qna_id number not null primary key,
    qna_parentId number default 0,
    qna_writeId varchar2(255),
    qna_title varchar2(255),
    qna_content varchar2(4000),
    qna_regDate date default sysdate,
    qna_status number default 0,
    product_code varchar2(255)
);

-- ���Ǳ� �̹��� ���̺�
create table qna_file(
    qna_fileId number not null primary key,
    qna_id number,
    qna_fileName varchar2(255)
);

-- ��ǰ�ı�
create table review (
    review_id number not null primary key,
    review_writeId varchar2(255),
    review_star number,
    review_title varchar2(255),
    review_content varchar2(4000),
    review_regDate date default sysdate,
    product_code varchar2(255)
);

-- ��ǰ�ı� �̹��� ���̺�
create table review_file(
    review_fileId number not null primary key,
    review_id number,
    review_fileName varchar2(255)
);

-- ������
CREATE SEQUENCE mem_seq
    INCREMENT BY 1
    START WITH 1
    NOCACHE;

CREATE SEQUENCE pro_seq
    INCREMENT BY 1
    START WITH 100
    NOCACHE;
    
CREATE SEQUENCE proFile_seq
    INCREMENT BY 1
    START WITH 100
    NOCACHE;

create SEQUENCE u_order_seq
    increment by 1
    start with 100
    nocache;

create SEQUENCE cart_seq
    increment by 1
    start with 100
    nocache;
select * from cart;

-- ������
INSERT INTO MEMBER VALUES ('admin','1234','������','01012345678','admin@uhdiya.com');
INSERT INTO MEMBER VALUES ('dayeun', 1111, 'dayeun', '01011112222', 'jdy010431@gmail.com');

INSERT INTO TOTAL_ORDER VALUES (order_list_num_seq.nextval, 'dayeun', 25000, sysdate, 'f');
INSERT INTO ORDERS VALUES (order_num_seq.nextval, sysdate, 1,'beans001', 1);
INSERT INTO ORDERS VALUES (order_num_seq.nextval, sysdate, 1,'beans002', 1);
INSERT INTO PAYMENT VALUES ('1111222233334444', 'shinhan', '26', '06', '23', 1);
INSERT INTO RECEIVER VALUES ('04038', '01022225555', 'seonarea', 1);
INSERT INTO ADDRESS VALUES ('04038', '����Ư���� ������ ��ȭ�� 122(������)' ,'3��');

INSERT INTO product VALUES (pro_seq.nextval,'beans001','[����] Ȧ��Ŀ�� �丣�ҳ� ���� 200g X 2��','Ŀ��','Ȧ�����',26000);
INSERT INTO product VALUES (pro_seq.nextval,'beans002','[����] Ȧ��Ŀ�� �ݷҺ�� �������� 200g X 2��','Ŀ��','Ȧ�����',24000);
INSERT INTO product VALUES (pro_seq.nextval,'beans003','[����] Ȧ��Ŀ�� �ɳ� ������ 200g X 2��','Ŀ��','Ȧ�����',26000);
INSERT INTO product VALUES (pro_seq.nextval,'beans004','[����] Ȧ��Ŀ�� ����� ���� 200g X 2��','Ŀ��','Ȧ�����',24000);
INSERT INTO product VALUES (pro_seq.nextval,'beans005','[����] Ȧ��Ŀ�� ��Ƽ���Ǿ� ���� 200g X 2��','Ŀ��','Ȧ�����',26000);
INSERT INTO product VALUES (pro_seq.nextval,'drip001','[����] Ŀ�Ƿ� �ڵ�帳 �丣�ҳ� 7T x 3��','Ŀ��','�ڵ�帳',16500);
INSERT INTO product VALUES (pro_seq.nextval,'drip002','[����] Ŀ�Ƿ� �ڵ�帳 ��Ƽ���Ǿ� 7T x 3��','Ŀ��','�ڵ�帳',15500);
INSERT INTO product VALUES (pro_seq.nextval,'drip003','[����] Ŀ�Ƿ� �ڵ�帳 �ݷҺ�� �������� 7T x 3��','Ŀ��','�ڵ�帳',15500);
INSERT INTO product VALUES (pro_seq.nextval,'cupcoffee001','[����] ��Ŀ�� 5�� X 2�� (���ǳ�/ī���/��ü �ݵ���/�ٴҶ�/���ݶ� ��ī)','����','��Ŀ��',18900);
INSERT INTO product VALUES (pro_seq.nextval,'capsule001','[����] Ŀ�Ƿ� ĸ��Ŀ�� �丣�ҳ� ���� 8T x 3��','Ŀ��','ĸ��Ŀ��',19900);
INSERT INTO product VALUES (pro_seq.nextval,'capsule002','[����] Ŀ�Ƿ� ĸ��Ŀ�� �ݷҺ�� �������� 8T x 3��','Ŀ��','ĸ��Ŀ��',18900);
INSERT INTO product VALUES (pro_seq.nextval,'capsule003','[����] Ŀ�Ƿ� ĸ��Ŀ�� ��Ƽ���Ǿ� ���� 8T x 3��','Ŀ��','ĸ��Ŀ��',19900);
INSERT INTO product VALUES (pro_seq.nextval,'machine001','[����] ĸ�� Ŀ�� �ӽ� Ǯ��Ű�� ��Ʈ(ĸ�� Ŀ�� �ӽ� 1��+��Ͻ�Ʈ ����ȿ���� 100T ƾ���̽�+ĸ��3�� 120��)','Ŀ��','Ŀ�Ǹӽ�',159000);
INSERT INTO product VALUES (pro_seq.nextval,'americano001','[����] ��Ͻ�Ʈ ��ī���� �Ƹ޸�ī�� 130T','��ƽĿ��','�Ƹ޸�ī��',19900);
INSERT INTO product VALUES (pro_seq.nextval,'americano002','[����] ��Ͻ�Ʈ ���ϵ� �Ƹ޸�ī�� 150T','��ƽĿ��','�Ƹ޸�ī��',25900);
INSERT INTO product VALUES (pro_seq.nextval,'ice001','[����] ���̽� �ڸ������� 190mlX30��','����','�ֽ�',21900);
INSERT INTO product VALUES (pro_seq.nextval,'ice002','[����] ���̽� �����ڵ� 190mlX30��','����','�ֽ�',21900);
INSERT INTO product VALUES (pro_seq.nextval,'latte001','[����] ��Ͻ�Ʈ �ٴҶ�� 50T','��ƽĿ��','��',21900);
INSERT INTO product VALUES (pro_seq.nextval,'latte002','[����] ��Ͻ�Ʈ ī��� 50T','��ƽĿ��','��',19500);
INSERT INTO product VALUES (pro_seq.nextval,'mix001','[����] ����� ��ī���� Ŀ�ǹͽ� 50T','��ƽĿ��','Ŀ�ǹͽ�',19500);
INSERT INTO product VALUES (pro_seq.nextval,'mix002','[����] ����� ������ Ŀ�ǹͽ� 280T','��ƽĿ��','Ŀ�ǹͽ�',34500);
INSERT INTO product VALUES (pro_seq.nextval,'blending001','[����] ����Ƽ ��Ʈ�κ��� ��ٺ� 10T x 4��','Ƽ','����Ƽ',34500);
INSERT INTO product VALUES (pro_seq.nextval,'tea001','[����] ���߽�ȭ�� 50T','Ƽ','������',16500);




INSERT INTO product_file VALUES (proFile_seq.nextval,'beans001.jpg','main','beans001');
INSERT INTO product_file VALUES (proFile_seq.nextval,'beans002.jpg','main','beans002');
INSERT INTO product_file VALUES (proFile_seq.nextval,'beans003.jpg','main','beans003');
INSERT INTO product_file VALUES (proFile_seq.nextval,'beans004.jpg','main','beans004');
INSERT INTO product_file VALUES (proFile_seq.nextval,'beans005.jpg','main','beans005');
INSERT INTO product_file VALUES (proFile_seq.nextval,'drip001.jpg','main','drip001');
INSERT INTO product_file VALUES (proFile_seq.nextval,'drip002.jpg','main','drip002');
INSERT INTO product_file VALUES (proFile_seq.nextval,'drip003.jpg','main','drip003');
INSERT INTO product_file VALUES (proFile_seq.nextval,'cupcoffee001.jpg','main','cupcoffee001');
INSERT INTO product_file VALUES (proFile_seq.nextval,'capsule001.jpg','main','capsule001');
INSERT INTO product_file VALUES (proFile_seq.nextval,'capsule002.jpg','main','capsule002');
INSERT INTO product_file VALUES (proFile_seq.nextval,'capsule003.jpg','main','capsule003');
INSERT INTO product_file VALUES (proFile_seq.nextval,'machine001.jpg','main','machine001');
INSERT INTO product_file VALUES (proFile_seq.nextval,'americano001.jpg','main','americano001');
INSERT INTO product_file VALUES (proFile_seq.nextval,'americano002.jpg','main','americano002');
INSERT INTO product_file VALUES (proFile_seq.nextval,'ice001.jpg','main','ice001');
INSERT INTO product_file VALUES (proFile_seq.nextval,'ice002.jpg','main','ice002');
INSERT INTO product_file VALUES (proFile_seq.nextval,'latte001.png','main','latte001');
INSERT INTO product_file VALUES (proFile_seq.nextval,'latte002.jpg','main','latte002');
INSERT INTO product_file VALUES (proFile_seq.nextval,'mix001.jpg','main','mix001');
INSERT INTO product_file VALUES (proFile_seq.nextval,'mix002.jpg','main','mix002');
INSERT INTO product_file VALUES (proFile_seq.nextval,'blending001.png','main','blending001');
INSERT INTO product_file VALUES (proFile_seq.nextval,'tea001.png','main','tea001');



INSERT INTO product_file VALUES (proFile_seq.nextval,'beans001_info.jpg','info','beans001');
INSERT INTO product_file VALUES (proFile_seq.nextval,'beans002_info.jpg','info','beans002');
INSERT INTO product_file VALUES (proFile_seq.nextval,'beans003_info.jpg','info','beans003');
INSERT INTO product_file VALUES (proFile_seq.nextval,'beans004_info.jpg','info','beans004');
INSERT INTO product_file VALUES (proFile_seq.nextval,'beans005_info.jpg','info','beans005');
INSERT INTO product_file VALUES (proFile_seq.nextval,'drip001_info.jpg','info','drip001');
INSERT INTO product_file VALUES (proFile_seq.nextval,'drip002_info.jpg','info','drip002');
INSERT INTO product_file VALUES (proFile_seq.nextval,'drip003_info.jpg','info','drip003');
INSERT INTO product_file VALUES (proFile_seq.nextval,'cupcoffee001_info.jpg','info','cupcoffee001');
INSERT INTO product_file VALUES (proFile_seq.nextval,'capsule001_info.jpg','info','capsule001');
INSERT INTO product_file VALUES (proFile_seq.nextval,'capsule002_info.jpg','info','capsule002');
INSERT INTO product_file VALUES (proFile_seq.nextval,'capsule003_info.jpg','info','capsule003');
INSERT INTO product_file VALUES (proFile_seq.nextval,'machine001_info.jpg','info','machine001');
INSERT INTO product_file VALUES (proFile_seq.nextval,'americano001_info.jpg','info','americano001');
INSERT INTO product_file VALUES (proFile_seq.nextval,'americano002_info.jpg','info','americano002');
INSERT INTO product_file VALUES (proFile_seq.nextval,'ice001_info.jpg','info','ice001');
INSERT INTO product_file VALUES (proFile_seq.nextval,'ice002_info.jpg','info','ice002');
INSERT INTO product_file VALUES (proFile_seq.nextval,'latte001_info.jpg','info','latte001');
INSERT INTO product_file VALUES (proFile_seq.nextval,'latte002_info.jpg','info','latte002');
INSERT INTO product_file VALUES (proFile_seq.nextval,'mix001_info.jpg','info','mix001');
INSERT INTO product_file VALUES (proFile_seq.nextval,'mix002_info.jpg','info','mix002');
INSERT INTO product_file VALUES (proFile_seq.nextval,'blending001_info.png','info','blending001');
INSERT INTO product_file VALUES (proFile_seq.nextval,'tea001_info.jpg','info','tea001');

Insert into NOTICE values (1,'admin','2018 ���� ��� �����ȳ�',null,to_date('18/02/01','RR/MM/DD'),678);
Insert into NOTICE values (2,'admin','2018�� �������� �̵�߿� �Բ�!',null,to_date('18/05/02','RR/MM/DD'),602);
Insert into NOTICE values (3,'admin','īī�� �÷��� ģ�� �̺�Ʈ!','īī�� �÷��� ģ�����Ը� �ִ� Ư���� ����!

�̵�� īī�� ��ģ �߰��� �ϸ�

�̵�� ���� ���� 200g �������� ���شٰ�!?


�������� ~ Ŀ�� ���ñ� �� ���� ���� ~ ?

������ ��� ��ŭ�� ��̿� ������ ǳ�̰� ��������

���̿÷� ���� �޾ư��� ?


?��Ͻ�Ʈ 180T? ������ �����ϰ�

���̿÷����� ���۱���!?


���� �ٷ� Ȯ���� ������ !!


����ó ��ũ
https://store.kakao.com/ediyastore/products/10213933',to_date('18/05/17','RR/MM/DD'),947);
Insert into NOTICE values (4,'admin','�ڵ�帳 Ŀ�� ���̿÷� ���Ž� �������','���Ⱓ

2018.06.11 ~ 2018.07.31',to_date('18/06/11','RR/MM/DD'),621);
Insert into NOTICE values (5,'admin','����ǰ ��� ��Ͻ�Ʈ ����� ����� !','?�ٸ���Ÿ ���� è�Ǿ�?

�����ظ��� �� ��� ���� ��Ҵ�!!



�̵�� ����ǰ ?��Ͻ�Ʈ ����� �����? ���



����ٸ���Ÿ ��ȸ è�Ǿ� ''���� �ظ���''��

�̵��Ŀ�ǰ� ���� �����Ͽ� �� Ư������

��Ͻ�Ʈ����ȿ����



���� ��𼭳� �����ϰ�

���� �ְ� �ٸ���Ÿ�� Ŀ�Ǹ� ��ܺ�����!




#�Բ�����_�����ְ�ٸ���ŸĿ��

#��Ͻ�Ʈ����ǰ #�����ظ�����Ͻ�Ʈ

#�̵��Ŀ�� #�̵�� #ediya #ediyacoffee',to_date('18/07/27','RR/MM/DD'),842);
Insert into NOTICE values (6,'admin','2018 �߼����� ��� ��������','2018 �߼��� ���ƿԽ��ϴ�.

��̰� ǳ��ο� �Ѱ��� �ǽð� �̵��Ŀ�� ������Ʈ�� ������ ���ϼ���.

��۸������� 09�� 19�� (��) PM 11�� 59�� �ֹ��ǿ� ���Ͽ� ���� �� ��� �����մϴ�.
�� ���� �ֹ����� 09�� 27�� (��) ���� ���������� �߼�ó�� �˴ϴ�.

�߼��������� ���� �ù����� 1~2�� ���� �� �� �ִٴ� �� ���غ�Ź�帮��
���� �˳��� ���ھȿ� �ֹ� ��Ź�帮�ڽ��ϴ�.

�����մϴ�. ���� ����ϴ� �̵�߰� �ǰڽ��ϴ�.^_^',to_date('18/09/05','RR/MM/DD'),817);
Insert into NOTICE values (7,'admin','NEW ����ǰ ��Ͻ�Ʈ ���� �� �� !','?(�ұټұ�) ���� ���� �����Ծ��!!!
#�̵�߸���Ʈ�� ������
�̵�� ����Ʈ���� �޴� #���ǳӶ�
���� ������ ��� �� �ִٱ��� ?

?��Ͻ�Ʈ ���� �� �� ���?
������ ī���� �Ƹ���� ������� ��������
���� �̵�߿����� ���� �� �ִ�
#��Ͻ�Ʈ���ǳӶ�

���ú��� �̵�߿��� ���������� ?',to_date('18/09/27','RR/MM/DD'),882);
Insert into NOTICE values (8,'admin','2019 �̵��Ŀ�� ������Ʈ','2019 �̵�߰� �غ��� ������Ʈ ����!

Ȳ�ݵ����� 2019�⿡�� �ູ���ϸ� �����ϱ� �ٶ��
�̵��Ŀ�Ƿ� ���� ���ϴ� ��������~

2019�⿡�� ���ϴ´�� ��~����!',to_date('19/01/08','RR/MM/DD'),741);
Insert into NOTICE values (9,'admin','�̵��Ŀ��, īī��������� ���� ���� ����','�̵��Ŀ��, īī��������� ���� ���� ����',to_date('19/03/13','RR/MM/DD'),748);

Insert into NOTICE_FILE values (1,1,'notice_1.jpg');
Insert into NOTICE_FILE values (2,2,'notice_2.jpg');
Insert into NOTICE_FILE values (3,4,'notice_4.jpg');
Insert into NOTICE_FILE values (4,5,'notice_5.jpg');
Insert into NOTICE_FILE values (5,6,'notice_6.jpg');
Insert into NOTICE_FILE values (6,7,'notice_7.jpg');
Insert into NOTICE_FILE values (7,8,'notice_8.jpg');
Insert into NOTICE_FILE values (8,9,'notice_9.jpg');

Insert into QNA values (1,0,'hong','���� ���׿�','�⵵ ���� ���ݵ� ���� �ڵ��ϴ� ���� �� ����',to_date('22/11/22','RR/MM/DD'),0,'001');
Insert into QNA values (2,0,'lee','�Խ��� ���Ժôµ�..','��� ���� �� �ϴ°̴ϴ�.',to_date('22/11/22','RR/MM/DD'),1,'001');

Insert into REVIEW values (1,'hong',4,'���̴׽�Ÿ','���ϴ��� e.printstacktrace()',to_date('22/11/24','RR/MM/DD'),'001');