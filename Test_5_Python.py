purchases = [
    {"item": "apple", "category": "fruit", "price": 1.2, "quantity": 10},
    {"item": "banana", "category": "fruit", "price": 0.5, "quantity": 5},
    {"item": "milk", "category": "dairy", "price": 1.5, "quantity": 2},
    {"item": "bread", "category": "bakery", "price": 2.0, "quantity": 3},
]

min_price = 1.0

def total_revenue(purchases):                     #Общая выручка
    answ = 0
    for product in purchases:
        answ += product['price'] * product['quantity']
    return answ


def items_by_category(purchases):                 #Ключ — категория, а значение — список уникальных товаров в этой категории.
    answ = {}
    for product in purchases:
        answ.setdefault(product['category'], []).append(product['item'])
    return answ

def expensive_purchases(purchases, min_price):    #Все покупки, где цена товара больше или равна min_price.
    answ = []
    for product in purchases:
        if product['price'] >= min_price:
            answ.append(product)
    return answ


def average_price_by_category(purchases):         #Cредние цены товаров по каждой категории.
    answ = {}

    for product in purchases:
        answ.setdefault(product['category'], []).append(product['price'])

    for category, count in answ.items():
        answ[category] = sum(count) / len(count)

    return answ

def most_frequent_category(purchases):            #Категория, в которой куплено больше всего единиц товаров.
    answ = {}
    
    for product in purchases:
        answ[product['category']] = answ.get(product['category'], 0) + product['quantity']
        
    return max(answ)


print(f'Общая выручка: {total_revenue(purchases)}')
print(f'Товары по категориям: {items_by_category(purchases)}')
print(f'Покупки дороже {min_price}: {expensive_purchases(purchases, min_price)}')
print(f'Средняя цена по категориям: {average_price_by_category(purchases)}')
print(f'Категория с наибольшим количеством проданных товаров: {most_frequent_category(purchases)}')