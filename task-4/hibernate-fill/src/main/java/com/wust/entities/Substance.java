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
public class Substance {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String name;
    @Enumerated
    private Source source;
    @ManyToMany
    @JoinTable(name = "substance_allergy", joinColumns = @JoinColumn(name = "substance_id"),
            inverseJoinColumns = @JoinColumn(name = "allergy_id"))
    @ToString.Exclude
    private Set<Allergy> allergies;
    @ManyToMany(mappedBy = "substances")
    @ToString.Exclude
    private Set<Medicine> medicines;
}