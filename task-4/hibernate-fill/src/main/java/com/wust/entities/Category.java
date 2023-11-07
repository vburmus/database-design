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
public class Category {
    @Id
    @Column(unique = true, length = 1)
    private String symbol;
    @Column(unique = true, nullable = false)
    private String description;
    @ManyToMany
    @JoinTable(name = "specialization_category", joinColumns = @JoinColumn(name = "category_symbol"),
            inverseJoinColumns = @JoinColumn(name = "specialization_id"))
    @ToString.Exclude
    private Set<Specialization> specializations;
    @OneToMany(mappedBy = "category")
    @ToString.Exclude
    private Set<Medicine> medicines;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Category category = (Category) o;
        return new EqualsBuilder().append(symbol, category.symbol).append(description, category.description).isEquals();
    }

    @Override
    public int hashCode() {
        return new HashCodeBuilder(17, 37).append(symbol).append(description).toHashCode();
    }
}