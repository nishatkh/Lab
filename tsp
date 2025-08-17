#include <stdio.h>
#include <limits.h>

#define MAX 20

int n;
int dist[MAX][MAX];
int visited[MAX];
int bestCost = INT_MAX;
int bestPath[MAX];
int currPath[MAX];

void tsp(int city, int count, int cost) {
    currPath[count - 1] = city;
    if (count == n && dist[city][0] > 0) {
        int totalCost = cost + dist[city][0];
        if (totalCost < bestCost) {
            bestCost = totalCost;
            for (int i = 0; i < n; i++) {
                bestPath[i] = currPath[i];
            }
            bestPath[n] = 0;
        }
        return;
    }
    for (int next = 0; next < n; next++) {
        if (!visited[next] && dist[city][next] > 0) {
            visited[next] = 1;
            tsp(next, count + 1, cost + dist[city][next]);
            visited[next] = 0;
        }
    }
}

int main() {
    printf("Enter number of cities: ");
    scanf("%d", &n);

    printf("Enter the distance matrix:\n");
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            scanf("%d", &dist[i][j]);
        }
    }

    visited[0] = 1;
    tsp(0, 1, 0);

    printf("\nMinimum tour cost: %d\n", bestCost);
    printf("Tour path: ");
    for (int i = 0; i <= n; i++) {
        printf("%d", bestPath[i]);
        if (i != n) printf(" -> ");
    }
    printf("\n");

    return 0;
}
