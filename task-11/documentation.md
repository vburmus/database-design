# Model Documentation

## Nodes

### 1. Doctor
- **Caption:** Doctor
- **Properties:**
  - first_name: STRING
  - last_name: STRING
  - pesel: STRING(11)
  - pzw_number: STRING(7)

### 2. Pharmacist
- **Caption:** Pharmacist
- **Properties:**
  - first_name: STRING
  - last_name: STRING
  - pesel: STRING(11)
  - pzwf_number: STRING(8)

### 3. Patient
- **Caption:** Patient
- **Properties:**
  - first_name: STRING
  - last_name: STRING
  - pesel: STRING(11)

### 4. User
- **Caption:** User
- **Properties:**
  - phone_number: STRING(15)
  - email: STRING
  - login: STRING
  - password: STRING
  - is_admin: BOOL

### 5. Pharmacy
- **Caption:** Pharmacy
- **Properties:**
  - name: STRING
  - address: STRING
  - phone_number: STRING
  - permit_number: STRING

### 6. Allergy
- **Caption:** Allergy
- **Properties:**
  - name: STRING
  - description: STRING

### 7. Substance
- **Caption:** Substance
- **Properties:**
  - name: STRING

### 8. Medicine
- **Caption:** Medicine
- **Properties:**
  - permit_number: STRING
  - name: STRING

### 9. Pharmaceutical_form
- **Caption:** Pharmaceutical_form
- **Properties:**
  - name: STRING

### 10. Category
- **Caption:** Category
- **Properties:**
  - symbol: CHAR
  - description: STRING

### 11. Specialization
- **Caption:** Specialization
- **Properties:**
  - name: STRING

### 12. Prescription
- **Caption:** Prescription
- **Properties:**
  - status: ENUM
  - annotation: STRING
  - expiration_date: DATE

## Relationships

### 1. HAVE
- **Type:** HAVE
- **Properties:** None
- **From Node Types:** Doctor, Pharmacist, Patient
- **To Node Types:** User
- **Description:** Indicates a relationship between a user and a healthcare professional or patient.

### 2. WORKS_IN
- **Type:** WORKS_IN
- **Properties:** None
- **From Node Types:** Pharmacist
- **To Node Types:** Pharmacy
- **Description:** Indicates the working relationship between a pharmacist and a pharmacy.

### 3. TO
- **Type:** TO
- **Properties:** None
- **From Node Types:** Allergy
- **To Node Types:** Substance
- **Description:** Indicates the substances associated with an allergy.

### 4. CONTAINS
- **Type:** CONTAINS
- **Properties:** None
- **From Node Types:** Medicine
- **To Node Types:** Substance
- **Description:** Indicates the substances contained in a medicine.

### 5. IS
- **Type:** IS
- **Properties:** None
- **From Node Types:** Medicine
- **To Node Types:** Pharmaceutical_form
- **Description:** Indicates the pharmaceutical form of a medicine.

### 6. TYPE
- **Type:** TYPE
- **Properties:** None
- **From Node Types:** Medicine
- **To Node Types:** Category
- **Description:** Indicates the category of a medicine.

### 7. OBTAINED
- **Type:** OBTAINED
- **Properties:**
  - issue_date: DATE
- **From Node Types:** Doctor
- **To Node Types:** Specialization
- **Description:** Indicates the specialization obtained by a doctor.

### 8. PERMITS
- **Type:** PERMITS
- **Properties:** None
- **From Node Types:** Specialization
- **To Node Types:** Category
- **Description:** Indicates the category permitted by a specialization.

### 9. ISSUED
- **Type:** ISSUED
- **Properties:**
  - issue_date: DATE
- **From Node Types:** Doctor
- **To Node Types:** Prescription
- **Description:** Indicates a prescription issued by a doctor.

### 10. FOR
- **Type:** FOR
- **Properties:** None
- **From Node Types:** Prescription
- **To Node Types:** Patient
- **Description:** Indicates the patient for whom the prescription is issued.

### 11. OF
- **Type:** OF
- **Properties:**
  - dosage: STRING
  - quantity: INT
- **From Node Types:** Prescription
- **To Node Types:** Medicine
- **Description:** Indicates the medicine and its dosage in a prescription.

### 12. REALIZED
- **Type:** REALIZED
- **Properties:**
  - realize_date: DATE
- **From Node Types:** Pharmacy
- **To Node Types:** Prescription
- **Description:** Indicates the realization of a prescription by a pharmacy.
