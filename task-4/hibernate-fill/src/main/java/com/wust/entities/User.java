package com.wust.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;

@Entity
@Getter
@Setter
@ToString
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(unique = true)
    private Long id;
    @Column(length = 15)
    private String phoneNumber;
    @Column(nullable = false)
    private String email;
    @Column(nullable = false, length = 45)
    private String login;
    @Column(nullable = false, length = 45)
    private String password;
    private Boolean isAdmin;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return new EqualsBuilder().append(id, user.id).append(phoneNumber, user.phoneNumber).append(email,
                user.email).append(login, user.login).append(password, user.password).append(isAdmin, user.isAdmin).isEquals();
    }

    @Override
    public int hashCode() {
        return new HashCodeBuilder(17, 37).append(id).append(phoneNumber).append(email).append(login).append(password).append(isAdmin).toHashCode();
    }
}