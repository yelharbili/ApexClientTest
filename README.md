# GESTIONREF - Application APEX Collaborative

## Projet
Application Oracle APEX de gestion du référentiel d'assurance (GESTIONREF - App ID 101).  
Développement collaboratif avec 2 développeurs utilisant Git branching.

## Environnement
| Paramètre | Valeur |
|---|---|
| Serveur | `192.168.108.145` |
| Port ORDS | `8181` |
| PDB | `ORASSUITPDB` |
| Schéma | `ORASSADM` |
| APEX Workspace | `ORASSUIT` |
| App APEX | `GESTIONREF` (ID 101) |

## Structure du projet
```
├── apex/           ← Export split de l'app APEX 101
├── db/             ← Scripts SQL (tables, packages, ORDS)
├── scripts/        ← Scripts d'export/import/deploy
└── README.md
```

## Workflow Git
- `main` : branche stable de référence
- `feature/list-clients` : Dev 1 — Page Liste des clients
- `feature/crud-detail-client` : Dev 2 — Pages CRUD + Détail client

## APIs REST (ORDS)
Base URL: `http://192.168.108.145:8181/ords/orassuitpdb/orassadm/referentiel/`

| Méthode | Endpoint | Description |
|---|---|---|
| GET | `/clients/` | Liste des clients |
| GET | `/clients/:id` | Détail d'un client |
| POST | `/clients/` | Créer un client |
