### `useAuthActions`

**Endpoints:**

- **Register**

  - **Method:** `POST`
  - **URL:** `/api/auth/signup`
  - **Request:** `{ first_name: string, last_name: string, email: string, password: string }`
  - **Response:** `{ user: User | null, error: string | null }`

- **Login**

  - **Method:** `POST`
  - **URL:** `/api/auth/login`
  - **Request:** `{ email: string, password: string }`
  - **Response:** `{ user: User | null, error: string | null }`

- **Logout**

  - **Method:** `POST`
  - **URL:** `/api/auth/logout`
  - **Response:** `void`

- **Delete Account**

  - **Method:** `DELETE`
  - **URL:** `/api/auth/delete-account`
  - **Response:** `void`

- **Update Account**

  - **Method:** `PATCH`
  - **URL:** `/api/auth/update`
  - **Request:** `Omit<User, "id">`
  - **Response:** `{ user: User | null, error: string | null }`

- **Get User Info**

  - **Method:** `GET`
  - **URL:** `/api/auth/me`
  - **Response:** `{ user: User | null, error: string | null }`

- **Reset Password**
  - **Method:** `POST`
  - **URL:** `/api/auth/reset-password`
  - **Request:** `{ email: string }`
  - **Response:** `void`

---

### `useCarActions`

**Endpoints:**

- **Fetch Cars**

  - **Method:** `GET`
  - **URL:** `/api/cars`
  - **Response:** `Car[]`

- **Create Car**

  - **Method:** `POST`
  - **URL:** `/api/cars`
  - **Request:** `Omit<Car, "id" | "repairs" | "profileId" | "gas">`
  - **Response:** `void`

- **Update Car**

  - **Method:** `PATCH`
  - **URL:** `/api/cars/{carId}`
  - **Request:** `Car`
  - **Response:** `void`

- **Delete Car**

  - **Method:** `DELETE`
  - **URL:** `/api/cars/{carId}`
  - **Response:** `void`

- **Add Repair**

  - **Method:** `POST`
  - **URL:** `/api/cars/{carId}/repairs`
  - **Request:** `Omit<Repair, "id" | "carId">`
  - **Response:** `void`

- **Update Repair**

  - **Method:** `PATCH`
  - **URL:** `/api/cars/{carId}/repairs/{repairId}`
  - **Request:** `Partial<Repair>`
  - **Response:** `void`

- **Remove Repair**

  - **Method:** `DELETE`
  - **URL:** `/api/cars/{carId}/repairs/{repairId}`
  - **Response:** `void`

- **Add Gas**
  - **Method:** `POST`
  - **URL:** `/api/cars/{carId}/gas`
  - **Request:** `Omit<Gas, "id">`
  - **Response:** `void`

## Type Definitions

### User

```typescript
export interface User {
  id: string;
  first_name?: string;
  last_name?: string;
  email: string;
}
```

### CarClass

```typescript
export interface CarClass {
  id: string;
  name: string;
}
```

### NotifyType

```typescript
export type NotifyType = "daily" | "weekly" | "monthly" | "never";
```

### Car

```typescript
export interface Car {
  id: string;
  make: string;
  model: string;
  year: number;
  classId: string;
  license_expiration_date?: Date;
  examination_date?: Date;
  notify_every: NotifyType;
  km: number;
  profileId: User["id"];
  repairs: Repair[];
  gas: Gas[];
}
```

### Gas

```typescript
export interface Gas {
  id: string;
  cost: number;
  km: number;
  date: string;
  carId: Car["id"];
  model: "petrol_80" | "petrol_92" | "petrol_95" | "diesel";
  liters: string;
}
```

### Repair

```typescript
export interface Repair {
  id: string;
  cost?: number;
  typeId: RepairType["id"];
  lastRepairKM: number;
  carId: Car["id"];
  date: string;
}
```

### RepairType

```typescript
export interface RepairType {
  id: string;
  name: string;
  reminder_km: number;
  profileId: User["id"] | null;
}
```
