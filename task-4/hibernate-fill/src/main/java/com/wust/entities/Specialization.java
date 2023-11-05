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
public class Specialization {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String name;
    @ManyToMany
    @JoinTable(name = "specialization_category", joinColumns = @JoinColumn(name = "specialization_id"),
            inverseJoinColumns = @JoinColumn(name = "category_symbol"))
    @ToString.Exclude
    private Set<Category> categories;
    @ManyToMany(mappedBy = "specializations")
    @ToString.Exclude
    private Set<Doctor> doctors;
}