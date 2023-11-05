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
public class Medicine {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "permit_number")
    private String permitNumber;
    private String name;
    @OneToOne
    @JoinColumn(name = "pharmaceutical_form_id", referencedColumnName = "id")
    private PharmaceuticalForm pharmaceuticalForm;
    @ManyToOne
    @JoinColumn(name = "category_symbol", referencedColumnName = "symbol")
    private Category category;
    @ManyToMany
    @JoinTable(name = "medicine_substance",
            joinColumns = @JoinColumn(name = "medicine_id"),
            inverseJoinColumns = @JoinColumn(name = "substance_id"))
    @ToString.Exclude
    private Set<Substance> substances;
    @OneToMany(mappedBy = "medicine")
    @ToString.Exclude
    private Set<Entry> entry;
}