-- ----------------------------
-- 1、部门表
-- ----------------------------
drop table if exists sys_dept;
create table sys_dept (
                          dept_id           INTEGER PRIMARY KEY AUTOINCREMENT,
                          parent_id         bigint(20)      default 0                  ,
                          ancestors         varchar(50)     default ''                 ,
                          dept_name         varchar(30)     default ''                 ,
                          order_num         int(4)          default 0                  ,
                          leader            varchar(20)     default null               ,
                          phone             varchar(11)     default null               ,
                          email             varchar(50)     default null               ,
                          status            char(1)         default '0'                ,
                          del_flag          char(1)         default '0'                ,
                          create_by         varchar(64)     default ''                 ,
                          create_time 	    datetime                                   ,
                          update_by         varchar(64)     default ''                 ,
                          update_time       datetime
) ;

-- ----------------------------
-- 2、用户信息表
-- ----------------------------
drop table if exists sys_user;
create table sys_user (
                          user_id           INTEGER PRIMARY KEY AUTOINCREMENT,
                          dept_id           bigint(20)      default null               ,
                          user_name         varchar(30)     not null                ,
                          nick_name         varchar(30)     not null                   ,
                          user_type         varchar(2)      default '00'               ,
                          email             varchar(50)     default ''                 ,
                          phonenumber       varchar(11)     default ''                 ,
                          sex               char(1)         default '0'                ,
                          avatar            varchar(100)    default ''                 ,
                          password          varchar(100)    default ''                 ,
                          status            char(1)         default '0'                ,
                          del_flag          char(1)         default '0'                ,
                          login_ip          varchar(128)    default ''                 ,
                          login_date        datetime                                   ,
                          create_by         varchar(64)     default ''                 ,
                          create_time       datetime                                   ,
                          update_by         varchar(64)     default ''                 ,
                          update_time       datetime                                   ,
                          remark            varchar(500)    default null
) ;


-- ----------------------------
-- 3、岗位信息表
-- ----------------------------
drop table if exists sys_post;
create table sys_post
(
    post_id       INTEGER PRIMARY KEY AUTOINCREMENT,
    post_code     varchar(64)     not null                   ,
    post_name     varchar(50)     not null                   ,
    post_sort     int(4)          not null                   ,
    status        char(1)         not null                   ,
    create_by     varchar(64)     default ''                 ,
    create_time   datetime                                  ,
    update_by     varchar(64)     default ''			       ,
    update_time   datetime                                   ,
    remark        varchar(500)    default null
) ;


-- ----------------------------
-- 4、角色信息表
-- ----------------------------
drop table if exists sys_role;
create table sys_role (
                          role_id             INTEGER PRIMARY KEY AUTOINCREMENT,
                          role_name            varchar(30)     not null                   ,
                          role_key             varchar(100)    not null                   ,
                          role_sort            int(4)          not null                   ,
                          data_scope           char(1)         default '1'               ,
                          menu_check_strictly  tinyint(1)      default 1                  ,
                          dept_check_strictly  tinyint(1)      default 1                 ,
                          status               char(1)         not null                   ,
                          del_flag             char(1)         default '0'                ,
                          create_by            varchar(64)     default ''                 ,
                          create_time          datetime                                   ,
                          update_by            varchar(64)     default ''                 ,
                          update_time          datetime                                  ,
                          remark               varchar(500)    default null
) ;


-- ----------------------------
-- 5、菜单权限表
-- ----------------------------
drop table if exists sys_menu;
create table sys_menu (
                          menu_id           INTEGER PRIMARY KEY AUTOINCREMENT,
                          menu_name         varchar(50)     not null                   ,
                          parent_id         bigint(20)      default 0                  ,
                          order_num         int(4)          default 0                  ,
                          path              varchar(200)    default ''                 ,
                          component         varchar(255)    default null              ,
                          query             varchar(255)    default null               ,
                          is_frame          int(1)          default 1                  ,
                          is_cache          int(1)          default 0                  ,
                          menu_type         char(1)         default ''                 ,
                          visible           char(1)         default 0                  ,
                          status            char(1)         default 0                  ,
                          perms             varchar(100)    default null               ,
                          icon              varchar(100)    default '#'                ,
                          create_by         varchar(64)     default ''               ,
                          create_time       datetime                                   ,
                          update_by         varchar(64)     default ''                 ,
                          update_time       datetime                                   ,
                          remark            varchar(500)    default ''
) ;


-- ----------------------------
-- 6、用户和角色关联表  用户N-1角色
-- ----------------------------
drop table if exists sys_user_role;
create table sys_user_role (
                               user_id   bigint(20) not null ,
                               role_id   bigint(20) not null ,
                               primary key(user_id, role_id)
) ;

-- ----------------------------
-- 7、角色和菜单关联表  角色1-N菜单
-- ----------------------------
drop table if exists sys_role_menu;
create table sys_role_menu (
                               role_id   bigint(20) not null ,
                               menu_id   bigint(20) not null ,
                               primary key(role_id, menu_id)
) ;


-- ----------------------------
-- 8、角色和部门关联表  角色1-N部门
-- ----------------------------
drop table if exists sys_role_dept;
create table sys_role_dept (
                               role_id   bigint(20) not null ,
                               dept_id   bigint(20) not null ,
                               primary key(role_id, dept_id)
) ;

-- ----------------------------
-- 9、用户与岗位关联表  用户1-N岗位
-- ----------------------------
drop table if exists sys_user_post;
create table sys_user_post
(
    user_id   bigint(20) not null ,
    post_id   bigint(20) not null ,
    primary key (user_id, post_id)
) ;

-- ----------------------------
-- 10、操作日志记录
-- ----------------------------
drop table if exists sys_oper_log;
create table sys_oper_log (
                              oper_id           INTEGER PRIMARY KEY AUTOINCREMENT,
                              title             varchar(50)     default ''                ,
                              business_type     int(2)          default 0                  ,
                              method            varchar(100)    default ''               ,
                              request_method    varchar(10)     default ''                ,
                              operator_type     int(1)          default 0                  ,
                              oper_name         varchar(50)     default ''                 ,
                              dept_name         varchar(50)     default ''                 ,
                              oper_url          varchar(255)    default ''                 ,
                              oper_ip           varchar(128)    default ''                 ,
                              oper_location     varchar(255)    default ''                 ,
                              oper_param        varchar(2000)   default ''                 ,
                              json_result       varchar(2000)   default ''                 ,
                              status            int(1)          default 0                  ,
                              error_msg         varchar(2000)   default ''                 ,
                              oper_time         datetime                                   ,
                              cost_time         bigint(20)      default 0
) ;

-- ----------------------------
-- 11、字典类型表
-- ----------------------------
drop table if exists sys_dict_type;
create table sys_dict_type
(
    dict_id          INTEGER PRIMARY KEY AUTOINCREMENT,
    dict_name        varchar(100)    default ''                 ,
    dict_type        varchar(100)    default ''                 ,
    status           char(1)         default '0'              ,
    create_by        varchar(64)     default ''                ,
    create_time      datetime                                   ,
    update_by        varchar(64)     default ''                 ,
    update_time      datetime                                  ,
    remark           varchar(500)    default null               ,
    unique (dict_type)
);



-- ----------------------------
-- 12、字典数据表
-- ----------------------------
drop table if exists sys_dict_data;
create table sys_dict_data
(
    dict_code        INTEGER PRIMARY KEY AUTOINCREMENT,
    dict_sort        int(4)          default 0                 ,
    dict_label       varchar(100)    default ''                 ,
    dict_value       varchar(100)    default ''                 ,
    dict_type        varchar(100)    default ''                 ,
    css_class        varchar(100)    default null               ,
    list_class       varchar(100)    default null               ,
    is_default       char(1)         default 'N'                ,
    status           char(1)         default '0'               ,
    create_by        varchar(64)     default ''                 ,
    create_time      datetime                                   ,
    update_by        varchar(64)     default ''                 ,
    update_time      datetime                                   ,
    remark           varchar(500)    default null
);

-- ----------------------------
-- 13、参数配置表
-- ----------------------------
drop table if exists sys_config;
create table sys_config (
                            config_id         INTEGER PRIMARY KEY AUTOINCREMENT,
                            config_name       varchar(100)    default ''                 ,
                            config_key        varchar(100)    default ''                 ,
                            config_value      varchar(500)    default ''                 ,
                            config_type       char(1)         default 'N'                ,
                            create_by         varchar(64)     default ''                ,
                            create_time       datetime                                   ,
                            update_by         varchar(64)     default ''                 ,
                            update_time       datetime                                   ,
                            remark            varchar(500)    default null
) ;


-- ----------------------------
-- 14、系统访问记录
-- ----------------------------
drop table if exists sys_logininfor;
create table sys_logininfor (
                                info_id        INTEGER PRIMARY KEY AUTOINCREMENT,
                                user_name      varchar(50)    default ''                ,
                                ipaddr         varchar(128)   default ''                ,
                                login_location varchar(255)   default ''                ,
                                browser        varchar(50)    default ''                ,
                                os             varchar(50)    default ''                ,
                                status         char(1)        default '0'               ,
                                msg            varchar(255)   default ''                ,
                                login_time     datetime

) ;



-- ----------------------------
-- 17、通知公告表
-- ----------------------------
drop table if exists sys_notice;
create table sys_notice (
                            notice_id         INTEGER PRIMARY KEY AUTOINCREMENT,
                            notice_title      varchar(50)     not null                   ,
                            notice_type       char(1)         not null                  ,
                            notice_content    longblob        default null               ,
                            status            char(1)         default '0'                ,
                            create_by         varchar(64)     default ''                 ,
                            create_time       datetime                                   ,
                            update_by         varchar(64)     default ''                 ,
                            update_time       datetime                                   ,
                            remark            varchar(255)    default null
) ;