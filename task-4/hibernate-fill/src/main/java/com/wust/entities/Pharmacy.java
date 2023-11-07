package com.wust.entities;

import jakarta.persistence.*;
import lombok.*;

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
    private Long id;
    private String name;
    private String address;
    private String phoneNumber;
    private String permitNumber;
    @ManyToMany
    @JoinTable(name = "pharmacy_pharmacist", joinColumns = @JoinColumn(name = "pharmacy_id"),
            inverseJoinColumns = @JoinColumn(name = "pharmacist_id"))
    @ToString.Exclude
    private Set<Pharmacist> pharmacists;
    @OneToMany(mappedBy = "pharmacy")
    @ToString.Exclude
    private Set<Entry> entries;
}