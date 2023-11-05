package com.wust.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToMany;
import lombok.*;

import java.util.Set;

@Entity
@Getter
@Setter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Category {
    @Id
    private String symbol;
    private String description;
    @ManyToMany(mappedBy = "categories")
    @ToString.Exclude
    private Set<Specialization> specializationSet;
    @OneToMany(mappedBy = "category")
    @ToString.Exclude
    private Set<Medicine> medicines;
}