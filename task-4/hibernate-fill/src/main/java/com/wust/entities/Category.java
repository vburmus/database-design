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
public class Category {
    @Id
    private String symbol;
    private String description;
    @ManyToMany
    @JoinTable(name = "specialization_category", joinColumns = @JoinColumn(name = "category_symbol"),
            inverseJoinColumns = @JoinColumn(name = "specialization_id"))
    @ToString.Exclude
    private Set<Specialization> specializations;
    @OneToMany(mappedBy = "category")
    @ToString.Exclude
    private Set<Medicine> medicines;
}