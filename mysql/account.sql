-- account table --
-- @Author: sgod<socraticfans@163.com> --
-- @Date: 2015-02-06 14:25             --

drop table if exists account;
create table if not exists account (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(id),
    name VARCHAR(60) NOT NULL,
    create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_login_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_logout_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB CHARACTER SET utf8;
