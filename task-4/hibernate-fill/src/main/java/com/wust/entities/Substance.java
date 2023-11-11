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
public class Substance {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(unique = true)
    private Long id;
    @Column(nullable = false, length = 45)
    private String name;
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Source source;
    @ManyToMany
    @JoinTable(name = "substance_allergy", joinColumns = @JoinColumn(name = "substance_id"),
            inverseJoinColumns = @JoinColumn(name = "allergy_id"))
    @ToString.Exclude
    private Set<Allergy> allergies;
    @ManyToMany(mappedBy = "substances")
    @ToString.Exclude
    private Set<Medicine> medicines;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Substance substance = (Substance) o;
        return new EqualsBuilder().append(id, substance.id).append(name, substance.name).append(source,
                substance.source).isEquals();
    }

    @Override
    public int hashCode() {
        return new HashCodeBuilder(17, 37)
                .append(id).append(name).append(source).toHashCode();
    }
}