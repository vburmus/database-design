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
public class Pharmacy {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(unique = true)
    private Long id;
    @Column(nullable = false, length = 45)
    private String name;
    @Column(nullable = false, length = 100)
    private String address;
    @Column(nullable = false, length = 15)
    private String phoneNumber;
    @Column(nullable = false, length = 15)
    private String permitNumber;
    @ManyToMany
    @JoinTable(name = "pharmacy_pharmacist", joinColumns = @JoinColumn(name = "pharmacy_id"),
            inverseJoinColumns = @JoinColumn(name = "pharmacist_id"))
    @ToString.Exclude
    private Set<Pharmacist> pharmacists;
    @OneToMany(mappedBy = "pharmacy")
    @ToString.Exclude
    private Set<Entry> entries;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Pharmacy pharmacy = (Pharmacy) o;
        return new EqualsBuilder().append(id, pharmacy.id).append(name, pharmacy.name).append(address, pharmacy.address).append(phoneNumber, pharmacy.phoneNumber).append(permitNumber, pharmacy.permitNumber).isEquals();
    }

    @Override
    public int hashCode() {
        return new HashCodeBuilder(17, 37).append(id).append(name).append(address).append(phoneNumber).append(permitNumber).toHashCode();
    }
}