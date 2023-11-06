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
@Table(name = "specialization")
public class Specialization {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    @ManyToMany(mappedBy = "specializationSet")
    @ToString.Exclude
    private Set<Category> categories;
    @ManyToMany(mappedBy = "specializations")
    @ToString.Exclude
    private Set<Doctor> doctors;
}