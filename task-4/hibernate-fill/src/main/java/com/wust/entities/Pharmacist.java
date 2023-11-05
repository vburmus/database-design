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
public class Pharmacist {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "first_name")
    private String firstName;
    @Column(name = "last_name")
    private String lastName;
    private String pesel;
    @Column(name = "pwzf_number")
    private String pwzfNumber;
    @OneToOne
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    private User user;
    @ManyToMany(mappedBy = "pharmacists")
    @ToString.Exclude
    private Set<Pharmacy> pharmacies;
    @OneToMany(mappedBy = "pharmacist")
    @ToString.Exclude
    private Set<Entry> entries;
}
