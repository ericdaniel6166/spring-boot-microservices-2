package com.eric6166.framework.model;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.experimental.FieldDefaults;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.EntityListeners;
import javax.persistence.MappedSuperclass;
import java.io.Serializable;
import java.time.LocalDateTime;

@Getter
@MappedSuperclass
@EntityListeners(AuditingEntityListener.class)
@FieldDefaults(level = AccessLevel.PROTECTED)
public abstract class BaseEntity<U> implements Serializable {

    @CreatedBy
    U createdBy;

    @CreatedDate
    LocalDateTime createdDate;

    @LastModifiedBy
    U lastModifiedBy;

    @LastModifiedDate
    LocalDateTime lastModifiedDate;
}
