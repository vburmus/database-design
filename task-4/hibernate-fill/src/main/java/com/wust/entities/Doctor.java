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
public class Doctor {
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
    @Column(nullable = false, length = 7)
    private String pwzNumber;
    @OneToOne
    @JoinColumn(name = "user_id", referencedColumnName = "id", nullable = false)
    private User user;
    @ManyToMany(cascade = {CascadeType.REFRESH, CascadeType.DETACH, CascadeType.PERSIST, CascadeType.MERGE})
    @JoinTable(name = "doctor_specialization", joinColumns = @JoinColumn(name = "doctor_id"),
            inverseJoinColumns = @JoinColumn(name = "specialization_id"))
    @ToString.Exclude
    private Set<Specialization> specializations;

    @OneToMany(mappedBy = "doctor")
    @ToString.Exclude
    private Set<Prescription> prescriptions;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Doctor doctor = (Doctor) o;
        return new EqualsBuilder().append(id, doctor.id).append(firstName, doctor.firstName).append(lastName,
                doctor.lastName).append(pesel, doctor.pesel).append(pwzNumber, doctor.pwzNumber).append(user,
                doctor.user).isEquals();
    }

    @Override
    public int hashCode() {
        return new HashCodeBuilder(17, 37)
                .append(id).append(firstName).append(lastName).append(pesel).append(pwzNumber).append(user).toHashCode();
    }
}