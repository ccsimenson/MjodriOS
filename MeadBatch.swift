import Foundation
import CoreData

class MeadBatch: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var type: String
    @NSManaged public var startDate: Date
    @NSManaged public var originalGravity: Double
    @NSManaged public var currentGravity: Double
    @NSManaged public var targetGravity: Double
    @NSManaged public var temperature: Double
    @NSManaged public var notes: String
    @NSManaged public var lastUpdated: Date
    @NSManaged public var status: String
    
    public var statusEnum: BatchStatus {
        get { BatchStatus(rawValue: status) ?? .active }
        set { status = newValue.rawValue }
    }
}

enum BatchStatus: String {
    case active = "Active"
    case completed = "Completed"
    
    var color: Color {
        switch self {
        case .active:
            return VikingTheme.Colors.gold
        case .completed:
            return VikingTheme.Colors.deepRed
        }
    }
}

class MeadBatchStore: ObservableObject {
    let container: NSPersistentContainer
    @Published var batches: [MeadBatch] = []
    
    init() {
        container = NSPersistentContainer(name: "MeadBatch")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load CoreData: \(error.localizedDescription)")
            }
        }
        fetchBatches()
    }
    
    func fetchBatches() {
        let request = NSFetchRequest<MeadBatch>(entityName: "MeadBatch")
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \MeadBatch.startDate, ascending: false)
        ]
        
        do {
            batches = try container.viewContext.fetch(request)
        } catch {
            print("Failed to fetch batches: \(error.localizedDescription)")
        }
    }
    
    func addBatch(
        name: String,
        type: String,
        originalGravity: Double,
        targetGravity: Double,
        temperature: Double,
        notes: String
    ) {
        let batch = MeadBatch(context: container.viewContext)
        batch.id = UUID()
        batch.name = name
        batch.type = type
        batch.startDate = Date()
        batch.originalGravity = originalGravity
        batch.currentGravity = originalGravity
        batch.targetGravity = targetGravity
        batch.temperature = temperature
        batch.notes = notes
        batch.lastUpdated = Date()
        batch.status = BatchStatus.active.rawValue
        
        save()
        fetchBatches()
    }
    
    func updateBatch(_ batch: MeadBatch) {
        batch.lastUpdated = Date()
        save()
        fetchBatches()
    }
    
    func deleteBatch(_ batch: MeadBatch) {
        container.viewContext.delete(batch)
        save()
        fetchBatches()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch {
            print("Failed to save batch: \(error.localizedDescription)")
        }
    }
}
