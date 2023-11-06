package com.wust.entities;

import jakarta.persistence.*;
import lombok.*;

import java.util.Objects;
import java.util.Set;

@Entity
@Getter
@Setter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "doctor")
public class Doctor {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "first_name")
    private String firstName;
    @Column(name = "last_name")
    private String lastName;
    private String pesel;
    @Column(name = "pwz_number")
    private String pwzNumber;
    @OneToOne
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    private User user;
    @ManyToMany
    @JoinTable(name = "doctor_specialization",
            joinColumns = @JoinColumn(name = "doctor_id"),
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
        if (!super.equals(o)) return false;
        Doctor that = (Doctor) o;
        return Objects.equals(id, that.id) && Objects.equals(firstName, that.firstName) &&
                Objects.equals(lastName, that.lastName) && Objects.equals(pesel, that.pesel) &&
                Objects.equals(pwzNumber, that.pwzNumber);
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), id, firstName, lastName, pesel, pwzNumber);
    }
}