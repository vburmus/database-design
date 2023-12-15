package com.wust.entities;

import jakarta.persistence.*;
import lombok.*;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;

import java.util.Set;

@Entity
@Getter
@Setter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Pharmacist {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(unique = true)
    private Long id;
    @Column(nullable = false, length = 45)
    private String firstName;
    @Column(nullable = false, length = 45)
    private String lastName;
    @Column(nullable = false, length = 11)
    private String pesel;
    @Column(nullable = false, length = 8)
    private String pwzfNumber;
    @OneToOne
    @JoinColumn(name = "user_id", referencedColumnName = "id", nullable = false)
    private User user;
    @ManyToMany(mappedBy = "pharmacists")
    @ToString.Exclude
    private Set<Pharmacy> pharmacies;
    @OneToMany(mappedBy = "pharmacist")
    @ToString.Exclude
    private Set<Entry> entries;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Pharmacist that = (Pharmacist) o;
        return new EqualsBuilder().append(id, that.id).append(firstName, that.firstName).append(lastName, that.lastName).append(pesel, that.pesel).append(pwzfNumber, that.pwzfNumber).append(user, that.user).isEquals();
    }

    @Override
    public int hashCode() {
        return new HashCodeBuilder(17, 37).append(id).append(firstName).append(lastName).append(pesel).append(pwzfNumber).append(user).toHashCode();
    }
}