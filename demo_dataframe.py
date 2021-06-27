import streamlit as st
import pandas as pd
from catboost import CatBoostRegressor
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error
import numpy as np

period=[10,15,20,25,30,35]

@st.cache()  # испльзуем если файл большой, держит в памяти
def get_data():
    df_s = pd.read_csv('data/housing.csv')
    return df_s

df = get_data()

st.header('MVP предсказание стоимости жилья') # создали заголовок
result=st.selectbox('выберите процент из периода от 10 до 35, с шагом 5',period)
#st.write(result)
if st.checkbox('Отобразить данные'): # создаем кнопку
    st.write(df)
    st.line_chart(df)

if st.button('Создать модель'): # вызываем кнопку
    #базу разделили 
    X_train, X_test, y_train, y_test = train_test_split(df.drop('MEDV', axis=1), df['MEDV'], test_size=(result/100),
                                                        random_state=0)
    st.text('Размер данных-'+str(X_train.shape) + str( X_test.shape)) #не может ф-ия принимать два аргумента, переводим в строку

    st.text('Старт модели')
    model = CatBoostRegressor() # вызываем модель
    model.fit(X_train,y_train)  # обучаем
    st.text('Обучили модель')
    pred = model.predict(X_test)  #прогноз
    st.text(str(np.sqrt(mean_squared_error(y_test,pred))))

