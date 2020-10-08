import Foundation

enum Direction {
    case down
    case right
    case upAndLeft

    var nextDirection: Direction {
        switch self {
        case .down:
            return .right
        case .right:
            return .upAndLeft
        case .upAndLeft:
            return .down
        }
    }
}

struct ArrayPoint {
    var row: Int
    var col: Int

    func isVaidPoint(sizeOfArray: Int) -> Bool {
        guard
            row >= 0,
            row < sizeOfArray,
            col >= 0,
            col < sizeOfArray else {
                return false
        }

        return true
    }
}

final class CurrentPosition {
    private var n: Int
    private var point: ArrayPoint
    private var value: Int
    private var direction: Direction
    private var canMove = true
    private var arr : [[Int]]
    var answer: [Int] {
        arr.flatMap { $0.filter { $0 != 0 } }
    }

    private var isVaidPoint: Bool {
        guard
            point.row >= 0,
            point.row < n,
            point.col >= 0,
            point.col < n else {
                return false
        }

        return true
    }

    private var nextPoint: ArrayPoint {
        switch direction {
        case .down:
            return ArrayPoint(row: point.row + 1, col: point.col)
        case .right:
            return ArrayPoint(row: point.row, col: point.col + 1)
        case .upAndLeft:
            return ArrayPoint(row: point.row - 1, col: point.col - 1)
        }
    }

    init(
        n: Int,
        point: ArrayPoint,
        value: Int,
        direction: Direction
    ) {
        self.n = n
        self.point = point
        self.value = value
        self.direction = direction
        self.arr = Array(repeating: Array(repeating: 0,count: n), count: n)
    }

    func moveDalPangE() {
        guard canMove else { return }

        insertValue()
        movePoint()
        moveDalPangE()
    }

    private func movePoint() {

        // 방향을 따라서 이동시 인덱스를 초과하는지 확인.
        // 초과한다면 현재 이동할 방향 바꿔주기
        if !nextPoint.isVaidPoint(sizeOfArray: n) {
            direction = direction.nextDirection
        }

        // 전체 array를 벗어나지 않았는데 이미 값이 있는경우 방향 한번 더 체인지
        if nextPoint.isVaidPoint(sizeOfArray: n),
            arr[nextPoint.row][nextPoint.col] != 0 {
            direction = direction.nextDirection
        }

        // 한번 더 방향을 바꿨는데도 이미 값이있다면 더이상 움직이지 못함
        if nextPoint.isVaidPoint(sizeOfArray: n),
            arr[nextPoint.row][nextPoint.col] == 0 {
            point = nextPoint
        } else {
            canMove = false
        }
    }

    private func insertValue() {
        let row = point.row
        let col = point.col

        arr[row][col] = value
        value += 1
    }

}

func solution(_ n: Int) -> [Int] {

    let currentPosition = CurrentPosition(
        n: n,
        point: ArrayPoint(row: 0, col: 0),
        value: 1,
        direction: .down
    )

    // move "달팽이"
    currentPosition.moveDalPangE()

    return currentPosition.answer
}


print(solution(4))
